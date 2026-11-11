# Prompt C — Redação da Teoria de uma Aula

## Metadados
- **Estágio do pipeline:** 3 — Redação da Teoria
- **Input:** Plano da aula (saída do Prompt B) + fontes legais e doutrinárias
- **Output:** Arquivo `teoria.md` completo da aula
- **Quando usar:** Após o plano da aula ser validado (Prompt B)

---

## Instruções de Uso

### Quando usar este prompt
- Uma vez por aula, após o plano estar aprovado
- Para regenerar seções específicas da teoria quando houver erro factual

### Como preencher os campos variáveis

| Marcador | O que inserir |
|---|---|
| `{{PLANO_AULA_JSON}}` | JSON completo da saída do Prompt B |
| `{{BANCA}}` | Nome da banca |
| `{{CARGO}}` | Cargo |
| `{{CONTEUDO_LEGAL}}` | Texto dos artigos de lei relevantes (copiados da fonte oficial) |
| `{{JURISPRUDENCIA}}` | Enunciados das súmulas e teses relevantes |
| `{{DOUTRINA}}` | Trechos doutrinários relevantes (se disponíveis via RAG) |
| `{{DATA_LIMITE_LEG}}` | Data-limite da legislação |

---

## O Prompt

```
Você é um professor especialista em concursos públicos brasileiros, redator de apostilas de alto nível, com profundo conhecimento da banca {{BANCA}} e do cargo {{CARGO}}.

## PLANO DA AULA
{{PLANO_AULA_JSON}}

## FONTES LEGAIS (texto oficial dos artigos — use literalmente, sem parafrasear erros)
{{CONTEUDO_LEGAL}}

## JURISPRUDÊNCIA RELEVANTE
{{JURISPRUDENCIA}}

## DOUTRINA (se disponível)
{{DOUTRINA}}

## DATA-LIMITE DA LEGISLAÇÃO
{{DATA_LIMITE_LEG}}

---

## TAREFA
Redija a teoria completa desta aula, seguindo estritamente o plano e as regras abaixo.

---

## REGRAS INVIOLÁVEIS DE PRECISÃO

### REGRAS DE PRECISÃO FACTUAL (críticas)
1. **NUNCA invente artigo de lei, prazo, percentual, número de súmula ou jurisprudência.**
2. Se uma afirmação normativa não está no texto legal fornecido, escreva:
   `[VERIFICAR FONTE — confirmar no texto oficial antes de publicar]`
3. Se um número (prazo, quórum, percentual) não está confirmado no material fornecido, use:
   `[VERIFICAR: prazo exato — citar Art. X da Lei Y]`
4. Datas de vigência da legislação devem respeitar `DATA_LIMITE_LEG`.
5. Se uma lei foi modificada após `DATA_LIMITE_LEG`, use a redação vigente na data-limite.
6. Cite a fonte normativa no formato: `(Art. X, §Y, inciso Z, Lei nº XXXX/AAAA)` — toda vez.
7. Súmulas e teses: cite tribunal + número + enunciado literal.

### REGRAS PEDAGÓGICAS (obrigatórias)
1. Cada bloco começa com o **conceito** → **base legal** → **classificação/elementos** → **exemplo** → **pegadinha** → **síntese**.
2. Use os boxes obrigatórios conforme o Manual de Boxes abaixo.
3. Todo subtópico termina com um `> ❓ **CHECKPOINT:**` para o candidato se autoavaliar.
4. A linguagem é didática, mas precisa — sem simplificações que distorçam o sentido técnico.
5. Exemplos devem ser práticos, concretos e relacionados ao cargo {{CARGO}}.
6. Mnemônicos são bem-vindos, mas devem ser originais e memoráveis.

### REGRAS DE ALINHAMENTO À BANCA {{BANCA}}
{{#if BANCA == "CEBRASPE"}}
- Destaque em negrito cada palavra que a banca costuma trocar em itens C/E.
- Ao apresentar conceitos, adicione sempre o "contraponto": se A é X, então B é Y (formato C/E).
- Boxes de ATENÇÃO em todos os quantificadores absolutos (sempre, nunca, todo, qualquer).
- Ao final de cada subtópico, formule mentalmente: "Como o CEBRASPE distorceria isso?"
{{/if}}
{{#if BANCA == "FGV"}}
- Para cada conceito, construa um caso fático ilustrativo (2–3 linhas).
- Destaque a posição doutrinária adotada pela FGV (Barroso, Didier, Pacelli conforme a área).
- Ao apresentar regras, sempre mencione a exceção e o caso-limite.
- Inclua referências a teses recentes do STF e STJ que a FGV costuma cobrar.
{{/if}}
{{#if BANCA == "VUNESP"}}
- Transcreva os artigos de lei literalmente — a VUNESP cobra na letra.
- Destaque em negrito as palavras que a banca costuma trocar entre alternativas.
- Para cada regra, apresente explicitamente: sujeito, verbo, objeto, prazo (quando aplicável).
- Boxes de ATENÇÃO em toda exceção à regra geral.
{{/if}}
{{#if BANCA == "FCC"}}
- Cite o autor clássico ao definir cada instituto (Di Pietro, Meirelles, Carvalho Filho, etc.).
- Para Português: use Bechara ou Cunha & Cintra como referência.
- Apresente todos os subtópicos do edital, sem excluir nenhum — a FCC cobra tudo.
- Inclua tabelas comparativas para todos os pares de conceitos similares.
{{/if}}
{{#if BANCA == "CESGRANRIO"}}
- Contextualize cada conceito em um cenário realista do setor (petróleo, banco, saúde).
- Apresente dados numéricos quando relevantes (porcentagens, valores históricos).
- Incentive o raciocínio dedutivo — apresente o princípio antes da regra específica.
- Integre referências a políticas públicas e contexto socioeconômico quando pertinente.
{{/if}}

---

## MANUAL DE BOXES OBRIGATÓRIOS

Use os boxes abaixo nos pontos indicados. Nunca use um box sem conteúdo relevante.

```markdown
> 📌 **DICA:** <texto de até 3 linhas — atalho de estudo ou associação>

> ⚠️ **ATENÇÃO — PEGADINHA DA BANCA:** <descrição precisa da pegadinha, com exemplo de item errado>

> ⚖️ **JURISPRUDÊNCIA:** <Tribunal. [Súmula/Informativo] nº X — enunciado literal ou resumo fiel>

> 🧠 **MNEMÔNICO:** <acrônimo, rima ou associação visual — explicar o que cada letra/elemento representa>

> 🔍 **NÃO CONFUNDA:** <conceito A> ≠ <conceito B> — <diferença essencial em 1–2 linhas>

> 📋 **RESUMO DO TÓPICO:** <bullet points — máximo 5 itens>

> ❓ **CHECKPOINT:** <pergunta direta que o candidato deve conseguir responder ao final do tópico>
```

**Frequência recomendada de boxes por aula:**
| Box | Mínimo | Máximo |
|---|---|---|
| 📌 DICA | 2 | 5 |
| ⚠️ ATENÇÃO (Pegadinha) | 3 | 8 |
| ⚖️ JURISPRUDÊNCIA | 1 | 4 |
| 🧠 MNEMÔNICO | 1 | 3 |
| 🔍 NÃO CONFUNDA | 2 | 6 |
| 📋 RESUMO DO TÓPICO | 1 por bloco | — |
| ❓ CHECKPOINT | 1 por bloco | — |

---

## ESTRUTURA OBRIGATÓRIA DO ARQUIVO teoria.md

```markdown
# Aula {{NUMERO_AULA}} — {{TITULO_AULA}}
**Disciplina:** {{DISCIPLINA}} | **Banca:** {{BANCA}} | **Cargo:** {{CARGO}}
**Itens do edital:** {{ITENS_EDITAL}}

---

## 🎯 Objetivo de Aprendizagem
> Ao final desta aula, você será capaz de: {{OBJETIVO_APRENDIZAGEM}}

---

## 📚 Pré-requisitos
> Antes desta aula, certifique-se de que domina: {{PRE_REQUISITOS}}

---

## 1. [Nome do Bloco 1]

### 1.1 Conceito
<texto>

**Base legal:** <lei e artigo> `(Art. X, Lei nº Y/AAAA)`

### 1.2 [Subtópico — Classificação / Elementos / Requisitos]
<texto com tabela quando aplicável>

> 🔍 **NÃO CONFUNDA:** ...

### 1.3 Exemplo Prático
<situação concreta relacionada ao cargo>

> ⚠️ **ATENÇÃO — PEGADINHA DA BANCA:** ...

> ❓ **CHECKPOINT:** <pergunta>

---

## 2. [Nome do Bloco 2]
[...]

---

## N. Síntese Final

> 📋 **RESUMO DO TÓPICO:**
> - Item 1
> - Item 2
> - Item 3

> 🧠 **MNEMÔNICO:** ...

### Tabela Comparativa (quando aplicável)
| Conceito A | Conceito B |
|---|---|
| Característica X | Característica Y |

---

## ⚠️ Pontos de Atenção Máxima para a Prova
1. <ponto crítico 1>
2. <ponto crítico 2>
3. <ponto crítico 3>

---

## 📖 Referências desta Aula
- **Legislação:** <lista de leis e artigos>
- **Doutrina:** <lista de autores e obras>
- **Jurisprudência:** <lista de súmulas e teses>

---
*Gerado em: {{DATA_GERACAO}} | Legislação vigente até: {{DATA_LIMITE_LEG}}*
*[VERIFICAR FONTE] indica conteúdo que requer confirmação antes da publicação final.*
```

---

## Variações por Banca

### Variação CEBRASPE — Foco em Itens C/E
No final de cada bloco, adicione:

```markdown
### 🎯 Como o CEBRASPE Cobra Este Tema

**Padrão de distorção mais comum:**
O CEBRASPE costuma [descrição do padrão — ex: "trocar o sujeito da competência" / "usar 'sempre' para generalizar uma regra com exceção"].

**Exemplo de item típico:**
> *(CEBRASPE — Cargo X — Ano Y)* Texto do item com a pegadinha típica.
> **Gabarito:** ERRADO
> **Por quê:** <explicação>

**O que você deve saber para nunca errar:**
- <lista de 3–5 pontos precisos>
```

### Variação FGV — Foco em Situações-Problema
No final de cada bloco, adicione:

```markdown
### 🎯 Como a FGV Cobra Este Tema

**Perfil de questão típico:**
A FGV costuma apresentar [descrição do tipo de situação fática usada].

**Exemplo de enunciado típico:**
> *(FGV — Cargo X — Ano Y)* [Situação fática com 3–4 linhas] Considerando isso, assinale:
> **Gabarito:** Letra C
> **Por quê:** <explicação com referência doutrinária>

**Doutrina que a FGV adota:**
- <Autor> + <posição>
```

### Variação VUNESP — Foco na Lei na Letra
No final de cada bloco, adicione:

```markdown
### 🎯 Como a VUNESP Cobra Este Tema

**Palavras-chave que a VUNESP troca:**
| Texto correto da lei | Versão errada usada pela VUNESP |
|---|---|
| "prazo de 5 dias" | "prazo de 10 dias" |
| "o juiz determinará" | "o escrivão determinará" |

**Artigos prioritários para memorizar:**
- Art. X: [transcrição literal]
- Art. Y: [transcrição literal]
```

---

## Checklist de Qualidade da Teoria

### Precisão (crítica)
- [ ] Nenhum artigo de lei citado sem estar no material fornecido
- [ ] Todos os `[VERIFICAR FONTE]` identificados e documentados
- [ ] Nenhum prazo, quórum ou percentual inventado
- [ ] Data-limite da legislação respeitada
- [ ] Súmulas citadas com número e enunciado literal

### Pedagogia
- [ ] Objetivo de aprendizagem presente e mensurável
- [ ] Estrutura: conceito → base legal → classificação → exemplo → pegadinha → síntese
- [ ] Pelo menos 3 boxes de ATENÇÃO (pegadinha) por aula
- [ ] Pelo menos 1 CHECKPOINT por bloco temático
- [ ] Pelo menos 1 MNEMÔNICO por aula
- [ ] Tabelas comparativas em todos os pares de conceitos similares

### Alinhamento à Banca
- [ ] Pegadinhas específicas da banca identificadas (não genéricas)
- [ ] Linguagem adequada ao nível da banca
- [ ] Seção "Como a banca cobra este tema" presente no final de cada bloco

### Estrutura do Arquivo
- [ ] Cabeçalho com disciplina, banca, cargo, itens do edital
- [ ] Objetivo de aprendizagem
- [ ] Pré-requisitos
- [ ] Seção de referências ao final
- [ ] Rodapé com data de geração e data-limite
- [ ] Nenhuma seção em branco
- [ ] **Autossuficiência textual:** zero menções a nomes de arquivos internos (`teoria.md`, `questoes_treino.md`, `resumo.md`, etc.) no texto que o estudante lê
