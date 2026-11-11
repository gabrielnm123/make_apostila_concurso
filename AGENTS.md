# AGENTS.md — Instruções para o Agente de IA

> **Leia este arquivo integralmente antes de qualquer ação.**
> Este projeto gera apostilas de concursos públicos brasileiros.
> Você é o agente responsável por executar o pipeline completo.

---

## 1. SEQUÊNCIA OBRIGATÓRIA DE LEITURA

Ao ser acionado, leia nesta ordem:

1. `AGENTS.md` ← você está aqui
2. `README.md` ← visão geral do projeto
3. `.env` ← dados do concurso atual
4. `docs/pipeline.md` ← arquitetura dos 9 estágios
5. `docs/pedagogia.md` ← princípios pedagógicos obrigatórios
6. `docs/bancas/<BANCA_NOME>.md` ← perfil da banca configurada no `.env`
7. `PLAN.md` ← **se já existir**, leia para retomar de onde parou

Se qualquer um desses arquivos não existir, relate o problema e aguarde instrução antes de prosseguir.

---

## 2. PRIMEIRO ATO: GERE O PLAN.md

Antes de escrever qualquer conteúdo de apostila, crie (ou atualize) o arquivo `PLAN.md` na raiz do projeto.

O `PLAN.md` deve conter:

```markdown
# PLAN.md — Plano de Execução

## Dados do Concurso
- Concurso: <CONCURSO_NOME>
- Órgão: <CONCURSO_ORGAO>
- Cargo: <CONCURSO_CARGO>
- Banca: <BANCA_NOME>
- Modo: <pós-edital | pré-edital | retificação>

## Fonte do Edital
- Status: <publicado | previsto | retificado>
- URL: <ou "arquivo local: <caminho>">
- Data-limite de legislação: <EDITAL_DATA_LIMITE_LEGISLACAO>

## Conteúdo Programático Extraído
<tabela hierárquica: disciplina > tópico > subtópico>
<se pré-edital: marcar cada item como "inferido" com justificativa>

## Mapa de Avaliação
- Total de questões: <n>
- Disciplinas e pesos: <tabela>
- Nota mínima geral: <n>
- Nota mínima por disciplina: <sim/não — detalhar se sim>
- Penalização por erro: <sim/não>
- Etapas eliminatórias além da objetiva: <listar>

## Plano de Capítulos
<lista: disciplina > aula > tópicos cobertos > itens do edital > orçamento>

## Ordem de Execução
<lista numerada de tarefas, com dependências>

## Status de Cobertura
<tabela: item do edital | capítulo | status (pendente/em progresso/concluído)>

## Premissas e Alertas
<lista de suposições feitas, especialmente em modo pré-edital>
```

---

## 3. SEGUNDO ATO: MANTENHA O HISTORY.md

A cada sessão ou bloco de trabalho concluído, atualize `HISTORY.md`:

```markdown
# HISTORY.md — Histórico de Execução

## Sessão <DATA_HORA>
- **O que foi feito:** <resumo>
- **Arquivos criados/modificados:** <lista>
- **Pendências:** <lista>
- **Alertas encontrados:** <ex.: lei desatualizada, item do edital ambíguo>
- **Próximo passo ao retomar:** <instrução direta>
```

> `PLAN.md` e `HISTORY.md` estão no `.gitignore`. São artefatos de sessão.

---

## 4. DETECÇÃO DE MODO DE OPERAÇÃO

Leia `EDITAL_STATUS` no `.env` e siga:

### Modo A — Pós-edital (publicado)
- Se `EDITAL_URL` preenchido: acesse e faça o download/leitura do PDF.
- Se `EDITAL_ARQUIVO_LOCAL` preenchido: leia o arquivo local.
- Execute o pipeline completo dos 9 estágios (ver `docs/pipeline.md`).

### Modo B — Pré-edital (previsto)
- **Não há edital disponível.** Infira o conteúdo programático por:
  1. Editais anteriores do mesmo órgão/cargo (URLs em `PRE_EDITAL_EDITAIS_ANTERIORES`)
  2. Editais de órgãos análogos (`PRE_EDITAL_ORGAOS_ANALOGOS`)
  3. Histórico de provas da banca para o cargo
  4. Legislação obrigatória da área (padrão nacional)
- **Marque cada item do conteúdo inferido** com:
  - `[INFERIDO]` — item baseado em editais anteriores/análogos
  - `[LEGISLAÇÃO OBRIGATÓRIA]` — item da legislação estruturante da área
  - `[HISTÓRICO BANCA]` — item cobrado frequentemente pela banca no cargo
- Produza uma seção `## Premissas e Alertas` no `PLAN.md`.
- Todo o material deve ter cabeçalho:
  ```
  > ⚠️ MATERIAL PRÉ-EDITAL — Baseado em histórico. Sujeito a revisão quando o edital for publicado.
  ```

### Modo C — Retificação
- Leia o edital original e a retificação (`EDITAL_RETIFICACAO_URL`).
- Identifique o diff: novos itens, itens removidos, alterações de peso.
- Atualize apenas as seções afetadas.
- Registre no `HISTORY.md` o que mudou e por quê.

---

## 5. REGRAS INVIOLÁVEIS

### 5.1 Precisão factual (crítico)
- **Nunca invente artigo de lei, prazo, percentual, número de súmula ou jurisprudência.**
- Toda afirmação normativa deve citar a fonte: `(Art. X, Lei nº Y/AAAA)`.
- Se não tiver a fonte disponível, escreva `[VERIFICAR FONTE — não confirmar sem pesquisa]`.
- Datas de vigência da legislação devem respeitar `EDITAL_DATA_LIMITE_LEGISLACAO`.

### 5.2 Alinhamento ao edital
- Nenhum tópico pode ser incluído que não esteja no conteúdo programático do edital (ou explicitamente declarado como pré-edital/inferido).
- A profundidade de cada item deve ser proporcional ao peso da disciplina e à incidência histórica da banca.

### 5.3 Alinhamento à banca
- Leia o perfil da banca em `docs/bancas/<BANCA_NOME>.md` antes de gerar qualquer questão.
- Questões CEBRASPE: itens independentes, C/E inequívoco, sem cadeia.
- Questões FCC: 5 alternativas, cobrança vertical, doutrina clássica.
- Questões FGV: situação-problema, alternativas com sinônimos imperfeitos.
- Questões VUNESP: literalidade da lei, troca de palavras-chave entre alternativas.

### 5.4 Estrutura obrigatória de cada aula
Cada aula deve ter, nesta ordem:
1. `teoria.md` — conceito → base legal → jurisprudência → exemplo → pegadinha → síntese
2. `resumo.md` — síntese em tópicos, tabelas e quadros comparativos
3. `mapa_mental.md` — estrutura radial + código Mermaid + descrição textual
4. `flashcards.csv` — frente;verso;tags (exportável para Anki)
5. `questoes_treino.md` — questões sem comentário + gabarito ao final
6. `questoes_comentadas.md` — gabarito + análise de cada alternativa + fundamento legal

### 5.5 Cobertura completa
- Antes de encerrar, verifique o `PLAN.md` — a tabela de Status de Cobertura deve estar 100% concluída.
- Se houver pendências, registre no `HISTORY.md` e continue na próxima sessão.

### 5.6 Autossuficiência textual e vedação a metalinguagem de arquivos
- **O material deve ser lido como um livro/apostila fechada e autossuficiente.**
- **Nunca mencione nomes de arquivos ou extensões internas** (`teoria.md`, `resumo.md`, `mapa_mental.md`, `flashcards.csv`, `questoes_treino.md`, `questoes_comentadas.md`, `_fontes_rag.md`, `PLAN.md`, etc.) no corpo do texto que o estudante lê.
- Use remissões pedagógicas naturais:
  - Em vez de `"abra o questoes_treino.md"` → use `"passe para as Questões de Treino"`.
  - Em vez de `"análise em questoes_comentadas.md"` → use `"análise detalhada nas Questões Comentadas"`.
  - Em vez de `"releia o resumo.md"` → use `"releia a seção de Resumo da aula"`.
  - Em vez de `"feche este arquivo e faça o checkpoint"` → use `"pause a leitura e escreva as respostas antes de prosseguir"`.
  - Em vez de `"gabarito em arquivo separado"` → use `"gabarito na seção de Gabarito ao final"`.
- O sumário da apostila deve listar títulos de seções e capítulos, nunca nomes de arquivos no disco.

---

## 6. BOXES E FORMATAÇÃO

Use os seguintes padrões de box em Markdown:

```markdown
> 📌 **DICA:** <texto>

> ⚠️ **ATENÇÃO — PEGADINHA DA BANCA:** <texto>

> ⚖️ **JURISPRUDÊNCIA:** <Tribunal, Súmula/Informativo nº X — texto>

> 🧠 **MNEMÔNICO:** <texto>

> 🔍 **NÃO CONFUNDA:** <X> ≠ <Y> — <explicação>

> 📋 **RESUMO DO TÓPICO:** <bullet points>

> ❓ **CHECKPOINT:** <pergunta para o leitor responder antes de continuar>
```

---

## 7. ESTRUTURA DE SAÍDA

Crie os arquivos dentro de `apostila_gerada/` (definido por `OUTPUT_DIR` no `.env`):

```
apostila_gerada/
├── 00_front/
│   ├── apresentacao.md         ← identificação do concurso, banca, cargo, data
│   ├── como_usar.md            ← legenda dos boxes, estratégia de estudo
│   ├── plano_de_estudo.md      ← cronograma semanal até a prova
│   ├── guia_da_banca.md        ← perfil da banca, armadilhas, estratégia
│   └── sumario.md              ← sumário mapeado à numeração do edital
│
├── 01_<slug_disciplina>/
│   ├── _meta.json              ← itens do edital cobertos, pesos, incidência
│   ├── aula_01_<slug_tema>/
│   │   ├── teoria.md
│   │   ├── resumo.md
│   │   ├── mapa_mental.md
│   │   ├── flashcards.csv
│   │   ├── questoes_treino.md
│   │   └── questoes_comentadas.md
│   └── aula_02_<slug_tema>/
│       └── ...
│
├── 90_simulados/
│   ├── simulado_01.md          ← proporção real da prova
│   └── gabarito_simulado_01.md
│
└── 91_glossario.md
```

O `_meta.json` de cada disciplina deve ter o formato:
```json
{
  "disciplina": "Direito Administrativo",
  "itens_edital": ["3.1", "3.2", "3.3"],
  "peso_prova": "20%",
  "n_questoes_prova": 10,
  "nota_minima": null,
  "incidencia_banca": "alta",
  "aulas": [
    { "id": "aula_01", "topicos": ["3.1 Princípios", "3.2 Ato administrativo"], "status": "concluída" }
  ]
}
```

---

## 8. CHECKLIST DE QUALIDADE (antes de encerrar)

Execute este checklist e registre o resultado no `HISTORY.md`:

**Cobertura**
- [ ] 100% dos itens do edital cobertos (ou pendências documentadas)
- [ ] Cada aula tem todos os 6 arquivos obrigatórios
- [ ] Sumário mapeado à numeração do edital

**Precisão**
- [ ] Nenhuma citação legal sem fonte verificada
- [ ] Datas de vigência da legislação respeitadas
- [ ] Gabaritos de questões revisados
- [ ] Nenhum `[VERIFICAR FONTE]` pendente sem alerta no HISTORY.md

**Pedagogia e Redação**
- [ ] Cada aula tem objetivo de aprendizagem explícito na teoria
- [ ] Boxes de ATENÇÃO em pontos de pegadinha identificados
- [ ] Questões comentadas com análise de distratores
- [ ] Flashcards com tags corretas para o Anki
- [ ] **Autossuficiência textual:** zero menções a arquivos técnicos internos (`.md`, `.csv`, `PLAN.md`, etc.) ou instruções operacionais de sistema no texto da apostila

**Estilo de banca**
- [ ] Questões no formato correto da banca
- [ ] Pegadinhas típicas da banca presentes nas questões e boxes
- [ ] Profundidade proporcional ao peso configurado

---

## 9. COMUNICAÇÃO COM O USUÁRIO

- Ao iniciar: relate o modo detectado, o plano resumido e peça confirmação antes de começar a escrever conteúdo.
- Ao encontrar ambiguidade no edital: relate e proponha a interpretação adotada.
- Ao encontrar legislação potencialmente desatualizada: alerte e marque `[VERIFICAR]`.
- Ao encerrar uma sessão parcial: liste claramente o que foi feito e o próximo passo.
- **Nunca silencie alertas de precisão.** Se há dúvida sobre um artigo ou prazo, diga.

---

## 10. EXPORTAÇÃO PARA PDF E EPUB

Após concluir todos os arquivos Markdown em `apostila_gerada/`, execute a conversão para os formatos configurados em `OUTPUT_FORMATOS` no `.env`. Os arquivos finais vão para `OUTPUT_PUBLICADO_DIR` (padrão: `apostila_publicada/`) — pasta ignorada pelo git.

### Estrutura esperada em `apostila_publicada/`

```
apostila_publicada/
├── <CONCURSO_ORGAO_SIGLA>_<CONCURSO_CARGO>_apostila_completa.pdf
├── <CONCURSO_ORGAO_SIGLA>_<CONCURSO_CARGO>_apostila_completa.epub
├── por_disciplina/
│   ├── 01_<slug_disciplina>.pdf
│   ├── 01_<slug_disciplina>.epub
│   └── ...
└── simulados/
    ├── simulado_01.pdf
    └── simulado_01.epub
```

### Comandos de conversão (Pandoc)

O agente deve gerar os arquivos usando Pandoc. Se Pandoc não estiver disponível, registrar no `HISTORY.md` e orientar o usuário a instalar.

**Apostila completa (todos os MD concatenados em ordem):**

```bash
# Gerar lista ordenada de arquivos
find apostila_gerada -name "*.md" | sort > /tmp/filelist.txt

# PDF (via LaTeX — melhor tipografia)
pandoc $(cat /tmp/filelist.txt) \
  --output="apostila_publicada/<SIGLA>_apostila_completa.pdf" \
  --pdf-engine=xelatex \
  --toc \
  --toc-depth=3 \
  --number-sections \
  -V lang=pt-BR \
  -V geometry:margin=2.5cm \
  -V fontsize=11pt \
  -V mainfont="DejaVu Serif" \
  -V monofont="DejaVu Sans Mono" \
  --highlight-style=tango

# EPUB
pandoc $(cat /tmp/filelist.txt) \
  --output="apostila_publicada/<SIGLA>_apostila_completa.epub" \
  --toc \
  --toc-depth=3 \
  --epub-chapter-level=2 \
  -V lang=pt-BR
```

**Por disciplina (um PDF/EPUB por pasta de disciplina):**

```bash
for dir in apostila_gerada/[0-9][0-9]_*/; do
  slug=$(basename "$dir")
  pandoc "$dir"/**/*.md \
    --output="apostila_publicada/por_disciplina/${slug}.pdf" \
    --pdf-engine=xelatex --toc -V lang=pt-BR
  pandoc "$dir"/**/*.md \
    --output="apostila_publicada/por_disciplina/${slug}.epub" \
    --toc -V lang=pt-BR
done
```

**Verificar se Pandoc está instalado:**
```bash
pandoc --version || echo "PANDOC NÃO ENCONTRADO — instale com: sudo apt install pandoc texlive-xetex"
```

### Regras de exportação

- Sempre gerar primeiro o Markdown completo; só depois converter.
- Se a conversão falhar (LaTeX ausente, etc.), registrar no `HISTORY.md` com o comando exato que falhou e a mensagem de erro.
- O nome do arquivo de saída deve incluir o `CONCURSO_ORGAO_SIGLA` e o `CONCURSO_CARGO` (slugificados: minúsculas, espaços → underscores).
- Mermaid não renderiza automaticamente no PDF via Pandoc — ao encontrar blocos ` ```mermaid `, converter para descrição textual ou imagem antes da exportação. Registrar como pendência se não for possível automaticamente.
- Verificar que `apostila_publicada/` existe antes de salvar; criar se necessário.

---

## 11. REFERÊNCIA RÁPIDA DOS ARQUIVOS

| Arquivo | Propósito |
|---|---|
| `.env` | Dados do concurso atual |
| `.env.example` | Template de configuração |
| `AGENTS.md` | Instruções operacionais (você está aqui) |
| `README.md` | Visão geral do projeto |
| `docs/pipeline.md` | Arquitetura dos 9 estágios |
| `docs/pedagogia.md` | Princípios pedagógicos |
| `docs/bancas/*.md` | Perfis das bancas |
| `docs/prompts/*.md` | Templates de prompt por tarefa |
| `PLAN.md` | Plano de execução (gerado por você) |
| `HISTORY.md` | Histórico de sessões (gerado por você) |
| `apostila_gerada/` | Markdown gerado (ignorado pelo git) |
| `apostila_publicada/` | PDF e EPUB finais (ignorado pelo git) |
