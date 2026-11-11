#!/usr/bin/env bash
# ============================================================================
# exportar.sh — Exportação da apostila para PDF, EPUB e DOCX (AGENTS.md §10)
#
# Lê .env, concatena os Markdown na ordem lógica e converte com Pandoc.
# Degrada com elegância: se uma engine não estiver instalada, registra e segue.
#
# Uso:  bash scripts/exportar.sh
# ============================================================================
set -uo pipefail

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$RAIZ" || exit 1

# --- Configuração (lê do .env, com padrões) ---------------------------------
if [ -f .env ]; then
  # shellcheck disable=SC1091
  set -a; . ./.env 2>/dev/null; set +a
fi
OUT_DIR="${OUTPUT_DIR:-apostila_gerada}"
PUB_DIR="${OUTPUT_PUBLICADO_DIR:-apostila_publicada}"
FORMATOS="${OUTPUT_FORMATOS:-md,pdf,epub,docx}"
# slugifica: minúsculas, sem acento, espaços/pontuação -> underscore
slug() {
  echo "$1" \
    | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/_/g; s/^_+|_+$//g'
}
SIGLA="$(slug "${CONCURSO_ORGAO_SIGLA:-SMS-FORTALEZA}")"
CARGO="$(slug "$(echo "${CONCURSO_CARGO:-ACS e ACE}" | cut -d',' -f1)")"
NOME_BASE="${SIGLA}_${CARGO}_apostila_completa"

mkdir -p "$PUB_DIR/por_disciplina" "$PUB_DIR/simulados" "$PUB_DIR/docx"

tem() { command -v "$1" >/dev/null 2>&1; }
log() { printf '%s\n' "$*"; }

if ! tem pandoc; then
  log "ERRO: pandoc não encontrado. Instale: sudo apt install pandoc"
  exit 1
fi
log "Pandoc: $(pandoc --version | head -1)"

ENGINE_PDF=""
if tem xelatex; then
  ENGINE_PDF="xelatex"
elif tem pdflatex; then
  ENGINE_PDF="pdflatex"
elif tem weasyprint; then
  ENGINE_PDF="weasyprint"
elif [ -x "$HOME/.local/bin/weasyprint" ]; then
  export PATH="$HOME/.local/bin:$PATH"
  ENGINE_PDF="weasyprint"
else
  log "AVISO: nenhuma engine PDF encontrada (xelatex/pdflatex/weasyprint) — PDF será pulado."
  log "       Instale com: sudo apt install pandoc texlive-xetex OU pip install weasyprint"
fi

# --- Lista ordenada de arquivos ---------------------------------------------
# Ordem: front → disciplinas → simulados → glossário
LISTA="/tmp/apostila_filelist_$$.txt"
{
  find "$OUT_DIR/00_front" -name '*.md' | sort
  find "$OUT_DIR" -maxdepth 1 -type d -name '0[1-9]_*' | sort | while read -r d; do
    find "$d" -name '*.md' | sort
  done
  find "$OUT_DIR/90_simulados" -name 'simulado_*.md' 2>/dev/null | sort
  [ -f "$OUT_DIR/91_glossario.md" ] && echo "$OUT_DIR/91_glossario.md"
} > "$LISTA"

TOTAL=$(wc -l < "$LISTA")
log "Arquivos a converter: $TOTAL"
[ "$TOTAL" -eq 0 ] && { log "ERRO: nenhum arquivo .md encontrado em $OUT_DIR"; exit 1; }

# --- Apostila completa ------------------------------------------------------
FALHAS=0

if [[ ",$FORMATOS," == *",pdf,"* ]]; then
  if [ -n "$ENGINE_PDF" ]; then
    log "→ PDF completo ($ENGINE_PDF)..."
    TMP_MD="/tmp/apostila_completa_$$.md"
    : > "$TMP_MD"
    while read -r f; do
      cat "$f" >> "$TMP_MD"
      if [ "$ENGINE_PDF" = "weasyprint" ]; then
        printf '\n\n<div style="page-break-after: always;"></div>\n\n' >> "$TMP_MD"
      else
        printf '\n\n\\newpage\n\n' >> "$TMP_MD"
      fi
    done < "$LISTA"

    PDF_OPTS=(--pdf-engine="$ENGINE_PDF" --toc --toc-depth=3 --number-sections -V lang=pt-BR --metadata title="Apostila — ${CONCURSO_NOME}")
    if [ "$ENGINE_PDF" = "xelatex" ] || [ "$ENGINE_PDF" = "pdflatex" ]; then
      PDF_OPTS+=(-V geometry:margin=2.5cm -V fontsize=11pt -V mainfont="DejaVu Serif" -V monofont="DejaVu Sans Mono" --highlight-style=tango)
    else
      PDF_OPTS+=(--highlight-style=tango)
    fi

    if pandoc "$TMP_MD" -o "$PUB_DIR/${NOME_BASE}.pdf" "${PDF_OPTS[@]}" 2>/tmp/pdferr_$$.txt; then
      log "  OK: $PUB_DIR/${NOME_BASE}.pdf"
    else
      log "  FALHOU PDF: $(tail -5 /tmp/pdferr_$$.txt)"; FALHAS=$((FALHAS+1))
    fi
    rm -f "$TMP_MD" /tmp/pdferr_$$.txt
  else
    log "PDF: PULADO (sem engine PDF)."
  fi
fi

if [[ ",$FORMATOS," == *",epub,"* ]]; then
  log "→ EPUB completo..."
  if xargs -a "$LISTA" pandoc -o "$PUB_DIR/${NOME_BASE}.epub" \
       --toc --toc-depth=3 --epub-chapter-level=2 -V lang=pt-BR \
       --metadata title="Apostila — ${CONCURSO_NOME}" 2>/tmp/epuberr_$$.txt; then
    log "  OK: $PUB_DIR/${NOME_BASE}.epub"
  else
    log "  FALHOU EPUB: $(tail -3 /tmp/epuberr_$$.txt)"; FALHAS=$((FALHAS+1))
  fi
  rm -f /tmp/epuberr_$$.txt
fi

if [[ ",$FORMATOS," == *",docx,"* ]]; then
  log "→ DOCX completo..."
  if xargs -a "$LISTA" pandoc -o "$PUB_DIR/docx/${NOME_BASE}.docx" \
       --toc --toc-depth=3 2>/tmp/docxerr_$$.txt; then
    log "  OK: $PUB_DIR/docx/${NOME_BASE}.docx"
  else
    log "  FALHOU DOCX: $(tail -3 /tmp/docxerr_$$.txt)"; FALHAS=$((FALHAS+1))
  fi
  rm -f /tmp/docxerr_$$.txt
fi

# --- Por disciplina ---------------------------------------------------------
log "→ Por disciplina..."
for dir in "$OUT_DIR"/0[1-9]_*/; do
  [ -d "$dir" ] || continue
  slug="$(basename "$dir")"
  mapfile -t ARQS < <(find "$dir" -name '*.md' | sort)
  [ ${#ARQS[@]} -eq 0 ] && continue

  if [[ ",$FORMATOS," == *",epub,"* ]]; then
    pandoc "${ARQS[@]}" -o "$PUB_DIR/por_disciplina/${slug}.epub" \
      --toc --toc-depth=2 -V lang=pt-BR >/dev/null 2>&1 \
      && log "  OK: por_disciplina/${slug}.epub" \
      || { log "  FALHOU: ${slug}.epub"; FALHAS=$((FALHAS+1)); }
  fi
  if [[ ",$FORMATOS," == *",pdf,"* ]] && [ -n "$ENGINE_PDF" ]; then
    pandoc "${ARQS[@]}" -o "$PUB_DIR/por_disciplina/${slug}.pdf" \
      --pdf-engine="$ENGINE_PDF" --toc -V lang=pt-BR --metadata title="${slug}" \
      >/dev/null 2>&1 \
      && log "  OK: por_disciplina/${slug}.pdf" \
      || { log "  FALHOU: ${slug}.pdf"; FALHAS=$((FALHAS+1)); }
  fi
done

# --- Simulados --------------------------------------------------------------
log "→ Simulados..."
for sim in "$OUT_DIR/90_simulados"/simulado_*.md; do
  [ -f "$sim" ] || continue
  base="$(basename "$sim" .md)"
  if [[ ",$FORMATOS," == *",epub,"* ]]; then
    pandoc "$sim" -o "$PUB_DIR/simulados/${base}.epub" -V lang=pt-BR >/dev/null 2>&1 \
      && log "  OK: simulados/${base}.epub" || { log "  FALHOU: ${base}.epub"; FALHAS=$((FALHAS+1)); }
  fi
  if [[ ",$FORMATOS," == *",pdf,"* ]] && [ -n "$ENGINE_PDF" ]; then
    pandoc "$sim" -o "$PUB_DIR/simulados/${base}.pdf" --pdf-engine="$ENGINE_PDF" \
      -V lang=pt-BR --metadata title="${base}" >/dev/null 2>&1 \
      && log "  OK: simulados/${base}.pdf" || { log "  FALHOU: ${base}.pdf"; FALHAS=$((FALHAS+1)); }
  fi
done

rm -f "$LISTA"

log ""
if [ "$FALHAS" -eq 0 ]; then
  log "Concluído sem falhas. Saída em: $PUB_DIR/"
else
  log "Concluído com $FALHAS falha(s). Veja o log acima e registre no HISTORY.md."
fi
exit 0
