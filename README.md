# make_apostila_concurso

Projeto genérico para geração automatizada de apostilas de concursos públicos brasileiros por agentes de IA (Claude, OpenCode, etc.).

Configure o `.env` com os dados do concurso e acione o agente — ele lê as instruções, o `.env`, pesquisa o edital e constrói a apostila.

---

## Início rápido

```bash
# 1. Clone o repositório
git clone <repo-url>
cd make_apostila_concurso

# 2. Copie e edite o .env
cp .env.example .env
# Abra .env e preencha os campos do concurso

# 3. Acione o agente de IA
# O agente lerá AGENTS.md, README.md e .env automaticamente.
```

---

## Estrutura do projeto

```
make_apostila_concurso/
├── .env.example          ← template de configuração (commitar)
├── .env                  ← configuração real do concurso (NÃO commitar)
├── .gitignore
├── README.md             ← este arquivo
├── AGENTS.md             ← instruções operacionais para o agente de IA
│
├── docs/
│   ├── bancas/           ← perfis das bancas (CEBRASPE, FGV, FCC…)
│   ├── pedagogia.md      ← princípios pedagógicos embutidos no pipeline
│   ├── pipeline.md       ← arquitetura completa dos 9 estágios
│   └── prompts/          ← templates de prompt por tarefa (A–G)
│
└── apostila_gerada/      ← saída do agente (gerado; não commitar)
    ← criado automaticamente pelo agente
```

> `PLAN.md` e `HISTORY.md` são gerados pelo agente em cada execução e estão no `.gitignore` — eles são artefatos de sessão, não do projeto base.

---

## Como funciona

1. **Leitura de contexto** — o agente lê `AGENTS.md` (instruções), `README.md` (visão geral) e `.env` (dados do concurso).
2. **Detecção de modo** — `EDITAL_STATUS=publicado` aciona o pipeline pós-edital; `previsto` aciona o modo pré-edital com pesquisa inferida.
3. **Geração do `PLAN.md`** — o agente cria um plano detalhado antes de escrever qualquer conteúdo.
4. **Pipeline de 9 estágios** — parsing do edital → verticalização → perfil da banca → planejamento → RAG → teoria → derivados → questões → QA.
5. **Saída** — arquivos Markdown na pasta `apostila_gerada/`, estruturados por disciplina/aula.

Veja `docs/pipeline.md` para a arquitetura completa e `AGENTS.md` para as instruções do agente.

---

## Modos de operação

| Modo | Quando usar | O que o agente faz |
|---|---|---|
| **Pós-edital (URL)** | `EDITAL_STATUS=publicado` + `EDITAL_URL` preenchido | Baixa e parseia o PDF do edital |
| **Pós-edital (arquivo)** | `EDITAL_STATUS=publicado` + `EDITAL_ARQUIVO_LOCAL` | Lê o arquivo local |
| **Pré-edital** | `EDITAL_STATUS=previsto` | Pesquisa editais anteriores e análogos, infere conteúdo, marca material como provisório |
| **Retificação** | `EDITAL_STATUS=retificado` | Aplica diff e atualiza seções afetadas |

---

## Bancas suportadas

| Banca | Formato | Particularidade |
|---|---|---|
| CEBRASPE | Certo/Errado | Penalização; pegadinhas linguísticas; jurisprudência |
| FGV | Múltipla escolha 5 | Casos fáticos; maior dificuldade; discursiva |
| FCC | Múltipla escolha 5 | Verticalização total; doutrina clássica |
| VUNESP | Múltipla escolha 5 | Letra de lei; "marque a INCORRETA"; nota de corte alta |
| CESGRANRIO | Múltipla escolha 5 | Contextualização; interdisciplinaridade |
| IBFC / IDECAN / AOCP | Múltipla escolha | Estilo variado; concursos policiais/municipais |

---

## Saída gerada

```
apostila_gerada/
├── 00_front/
│   ├── apresentacao.md
│   ├── como_usar.md
│   ├── plano_de_estudo.md
│   ├── guia_da_banca.md
│   └── sumario.md
├── 01_<disciplina>/
│   ├── _meta.json
│   └── aula_01/
│       ├── teoria.md
│       ├── resumo.md
│       ├── mapa_mental.md
│       ├── flashcards.csv
│       ├── questoes_treino.md
│       └── questoes_comentadas.md
├── ...
├── 90_simulados/
└── 91_glossario.md
```

---

## Princípios pedagógicos

A apostila segue evidências de ciência cognitiva:

- **Recuperação ativa** — questões no meio da teoria, não só no final
- **Repetição espaçada** — resumos e flashcards calibrados para D+1, D+7, D+30
- **Prática > teoria** — 60-70% do volume em questões e revisão
- **Rastreabilidade factual** — toda afirmação normativa cita a fonte (RAG obrigatório)
- **Alinhamento de banca** — conteúdo parametrizado pelo perfil da banca configurada

---

## Contribuindo

Este é um projeto-template. Para adaptar a um novo concurso, basta editar o `.env`. Para melhorar os perfis de banca ou os prompts, edite os arquivos em `docs/bancas/` e `docs/prompts/`.
