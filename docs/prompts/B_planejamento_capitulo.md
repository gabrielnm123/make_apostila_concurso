# Prompt B — Planejamento de Capítulo/Aula

## Metadados
- **Estágio do pipeline:** 2 — Planejamento de Capítulo
- **Input:** JSON do escopo (saída do Prompt A) + metadados do concurso
- **Output:** Plano detalhado da aula com objetivos, estrutura, orçamento e cronograma
- **Quando usar:** Antes de redigir a teoria — uma vez por aula/capítulo

---

## Instruções de Uso

### Quando usar este prompt
- Após executar o Prompt A e ter o JSON do escopo validado
- Uma vez para cada aula do plano de capítulos
- Ao replanejar após retificação de edital

### Como preencher os campos variáveis

| Marcador | O que inserir |
|---|---|
| `{{DISCIPLINA}}` | Nome da disciplina (ex: "Direito Administrativo") |
| `{{NUMERO_AULA}}` | Número sequencial da aula dentro da disciplina (ex: "03") |
| `{{TITULO_AULA}}` | Título provisório da aula (ex: "Atos Administrativos — Conceito, Requisitos e Classificação") |
| `{{ITENS_EDITAL}}` | JSON dos itens do edital cobertos por esta aula (extraídos do Prompt A) |
| `{{BANCA}}` | Nome da banca |
| `{{CARGO}}` | Cargo |
| `{{PESO_DISCIPLINA}}` | Percentual/número de questões da disciplina na prova |
| `{{INCIDENCIA_BANCA}}` | Histórico de incidência do tema na banca (alta/média/baixa + exemplos) |
| `{{DATA_LIMITE_LEG}}` | Data-limite da legislação |
| `{{AULAS_ANTERIORES}}` | Títulos das aulas anteriores da mesma disciplina (para evitar redundância) |

---

## O Prompt

```
Você é um pedagogo especialista em concursos públicos brasileiros e um profundo conhecedor da banca {{BANCA}}.

## CONTEXTO DA AULA
- Disciplina: {{DISCIPLINA}}
- Aula nº: {{NUMERO_AULA}}
- Título provisório: {{TITULO_AULA}}
- Cargo: {{CARGO}}
- Banca: {{BANCA}}
- Peso da disciplina: {{PESO_DISCIPLINA}} questões / {{PESO_PERCENTUAL}}% da prova
- Incidência histórica do tema: {{INCIDENCIA_BANCA}}
- Data-limite da legislação: {{DATA_LIMITE_LEG}}

## ITENS DO EDITAL COBERTOS POR ESTA AULA
{{ITENS_EDITAL}}

## AULAS ANTERIORES DA MESMA DISCIPLINA (evitar redundância)
{{AULAS_ANTERIORES}}

## TAREFA
Produza um plano completo para esta aula. O plano deve ser detalhado o suficiente para que outro agente redija o conteúdo sem intervenção humana.

## REGRAS OBRIGATÓRIAS
1. O plano deve mapear TODOS os itens do edital listados acima — sem omissão.
2. A profundidade de cada subtópico deve ser proporcional ao peso do tema na prova.
3. Identifique os pontos de maior incidência da banca {{BANCA}} para este tema.
4. Liste as pegadinhas típicas da banca para este tema.
5. Indique as fontes legais e doutrinárias que devem ser consultadas ao redigir o conteúdo.
6. Estime o número de questões de treino e flashcards para esta aula.
7. Defina os pré-requisitos — o candidato precisa saber X antes desta aula.
8. Responda em JSON + seções Markdown conforme o formato abaixo.

## FORMATO DE SAÍDA

### PARTE 1: JSON de Metadados
```json
{
  "disciplina": "{{DISCIPLINA}}",
  "numero_aula": "{{NUMERO_AULA}}",
  "titulo_definitivo": "<título conciso e descritivo>",
  "slug": "<titulo-em-kebab-case>",
  "itens_edital_cobertos": ["3.1", "3.2"],
  "objetivo_aprendizagem": "<O candidato será capaz de... [verbo no infinitivo + resultado mensurável]>",
  "pre_requisitos": ["<aula ou conceito que deve ser conhecido antes>"],
  "tempo_estimado_estudo_horas": 3,
  "orcamento_conteudo": {
    "teoria_paginas": 8,
    "resumo_paginas": 2,
    "mapa_mental_nos": 15,
    "flashcards": 20,
    "questoes_treino": 15,
    "questoes_comentadas": 10
  },
  "fontes_legais": [
    {"lei": "Lei nº 8.666/93", "artigos_relevantes": ["Art. 1º", "Art. 22"], "observacao": "Substituída pela 14.133/21 — verificar data-limite"},
    {"lei": "Lei nº 14.133/21", "artigos_relevantes": ["Art. 1º ao 20", "Art. 75"]}
  ],
  "fontes_doutrinárias": [
    {"autor": "Maria Sylvia Di Pietro", "obra": "Direito Administrativo", "edicao": "36ª ed.", "capitulos": ["Cap. 7"]},
    {"autor": "José dos Santos Carvalho Filho", "obra": "Manual de Direito Administrativo", "edicao": "37ª ed.", "capitulos": ["Cap. 5"]}
  ],
  "jurisprudencia_relevante": [
    {"tribunal": "STJ", "tipo": "Súmula", "numero": "473", "enunciado": "A Administração pode anular seus próprios atos..."},
    {"tribunal": "STF", "tipo": "Repercussão Geral", "numero": "RE 633.703", "tese": "...", "alerta": "Verificar se dentro da data-limite"}
  ],
  "incidencia_historica_banca": "alta",
  "pontos_mais_cobrados": [
    "Modalidades de licitação e seus limites de valor (Lei 14.133/21)",
    "Hipóteses de dispensa e inexigibilidade",
    "Fases do processo licitatório"
  ],
  "pegadinhas_tipicas_banca": [
    "Confusão entre dispensa e inexigibilidade — a banca {{BANCA}} frequentemente inverte as hipóteses",
    "Troca de modalidade de licitação pelo valor de contrato",
    "Afirmar que o pregão só é cabível para bens comuns (errado — cabe também para serviços comuns)"
  ],
  "bandeiras_de_atencao": [
    "VERIFICAR: Lei 14.133/21 — artigos que entraram em vigor na data X podem estar fora da data-limite",
    "VERIFICAR: Súmula 473 STF × STJ — numerações diferentes para o mesmo enunciado"
  ],
  "status": "planejado"
}
```

### PARTE 2: Estrutura Narrativa da Teoria

Produza a estrutura da teoria em Markdown, com os seguintes blocos:

## Estrutura da Teoria — Aula {{NUMERO_AULA}}: {{TITULO_AULA}}

### Bloco 1 — Introdução e Contextualização (estimativa: 0,5 página)
- <O que o candidato vai aprender>
- <Por que esse tema cai na prova da {{BANCA}}>
- <Conexão com temas anteriores>

### Bloco 2 — [Nome do primeiro subtópico] (estimativa: X páginas)
- Conceito
- Base legal: <lei e artigo>
- Classificação/Elementos/Requisitos (conforme aplicável)
- Exemplo prático
- Pegadinha: <descrição da pegadinha típica>

### Bloco 3 — [Nome do segundo subtópico] (estimativa: X páginas)
[...]

### Bloco N — Síntese e Pontos de Prova (estimativa: 0,5 página)
- Mnemônicos
- Tabela comparativa (se aplicável)
- Checklist do que o candidato deve saber ao final

### PARTE 3: Plano de Questões

| Nº | Tipo | Subtópico | Armadilha/Dificuldade | Fundamento |
|---|---|---|---|---|
| Q01 | C/E (CEBRASPE) ou ME (outras) | <subtópico> | <armadilha usada> | <lei/art.> |
[...]
```

---

## Exemplo de Saída

### JSON de Metadados (trecho)
```json
{
  "disciplina": "Direito Administrativo",
  "numero_aula": "03",
  "titulo_definitivo": "Licitações — Modalidades, Dispensa e Inexigibilidade",
  "slug": "licitacoes-modalidades-dispensa-inexigibilidade",
  "itens_edital_cobertos": ["4.1", "4.2", "4.3"],
  "objetivo_aprendizagem": "Ao final desta aula, o candidato será capaz de identificar a modalidade licitatória correta para cada situação, distinguir dispensa de inexigibilidade e resolver questões da banca VUNESP sobre a Lei 14.133/21 com 80%+ de acerto.",
  "pre_requisitos": ["Aula 01 — Princípios do Direito Administrativo", "Aula 02 — Atos Administrativos"],
  "tempo_estimado_estudo_horas": 4,
  "orcamento_conteudo": {
    "teoria_paginas": 10,
    "resumo_paginas": 3,
    "mapa_mental_nos": 20,
    "flashcards": 25,
    "questoes_treino": 20,
    "questoes_comentadas": 12
  }
}
```

### Estrutura da Teoria (trecho)
```markdown
## Bloco 1 — Introdução: Por que Licitações Cai Sempre (0,5 página)
- Licitações é um dos temas mais cobrados em Dir. Administrativo na VUNESP
- A Lei 14.133/21 substituiu a 8.666/93 — verificar data de vigência plena
- Conexão: princípios administrativos (aula anterior) são fundamento das licitações

## Bloco 2 — Modalidades de Licitação (3 páginas)
- Conceito: procedimento formal para selecionar a melhor proposta
- Modalidades (Lei 14.133/21): Concorrência, Concurso, Leilão, Pregão, Diálogo Competitivo
- Critérios de cabimento: por tipo de objeto, não por valor (mudança da 14.133)
- Pegadinha VUNESP: "O pregão é cabível apenas para bens comuns" → ERRADO (cabe para serviços comuns também)
```

---

## Checklist de Validação do Plano

Antes de prosseguir para a redação da teoria, verifique:

**Cobertura**
- [ ] Todos os `itens_edital_cobertos` aparecem na estrutura da teoria
- [ ] Nenhum bloco da teoria cobre item fora do edital
- [ ] `objetivo_aprendizagem` é mensurável (verbo + resultado)

**Fontes**
- [ ] Todas as fontes legais têm os artigos específicos identificados
- [ ] Fontes doutrinárias são compatíveis com o perfil da banca
- [ ] `bandeiras_de_atencao` alertam sobre legislação perto da data-limite

**Orçamento**
- [ ] Número de páginas de teoria é proporcional ao peso da disciplina
- [ ] Número de flashcards e questões é viável para o cronograma

**Pegadinhas**
- [ ] Pelo menos 1 pegadinha por bloco temático identificada
- [ ] Pegadinhas são específicas da banca {{BANCA}}, não genéricas
