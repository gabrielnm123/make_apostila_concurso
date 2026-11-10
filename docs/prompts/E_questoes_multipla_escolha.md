# Prompt E — Geração de Questões de Múltipla Escolha

## Metadados
- **Estágio do pipeline:** 4b — Geração de Questões (Múltipla Escolha)
- **Input:** Teoria da aula + plano de questões
- **Output:** Questões no formato de múltipla escolha com 5 alternativas
- **Quando usar:** Para bancas FCC, FGV, VUNESP, CESGRANRIO, IBFC e demais que usam ME

---

## Instruções de Uso

### Quando usar este prompt
- Para qualquer banca que use múltipla escolha com 5 alternativas
- Adapte o prompt usando a seção de **Variações por Banca** abaixo
- Pode ser combinado com o Prompt D para simulados mistos

### Como preencher os campos variáveis

| Marcador | O que inserir |
|---|---|
| `{{TEORIA_AULA}}` | Texto completo da teoria (saída do Prompt C) |
| `{{PLANO_QUESTOES}}` | Tabela de questões do plano (Prompt B) |
| `{{BANCA}}` | FCC, FGV, VUNESP, CESGRANRIO, IBFC, etc. |
| `{{DISCIPLINA}}` | Nome da disciplina |
| `{{TITULO_AULA}}` | Título da aula |
| `{{CARGO}}` | Cargo |
| `{{N_QUESTOES}}` | Número de questões a gerar |
| `{{DISTRIBUICAO}}` | Distribuição de dificuldade (ex: "5 fácil, 7 médio, 3 difícil") |
| `{{TIPO_ENUNCIADO}}` | Proporção de "correta" × "incorreta" (ex: "70% correta, 30% incorreta") |
| `{{DATA_LIMITE_LEG}}` | Data-limite da legislação |

---

## O Prompt Base

```
Você é um especialista em elaboração de questões de concurso público no padrão {{BANCA}}, com profundo conhecimento de {{DISCIPLINA}} e das características e armadilhas típicas desta banca.

## CONTEXTO
- Disciplina: {{DISCIPLINA}}
- Aula: {{TITULO_AULA}}
- Cargo: {{CARGO}}
- Banca: {{BANCA}}
- Data-limite da legislação: {{DATA_LIMITE_LEG}}
- Questões a gerar: {{N_QUESTOES}}
- Distribuição de dificuldade: {{DISTRIBUICAO}}
- Tipo de enunciado: {{TIPO_ENUNCIADO}}

## TEORIA DA AULA (base de conteúdo)
{{TEORIA_AULA}}

## PLANO DE QUESTÕES
{{PLANO_QUESTOES}}

---

## TAREFA
Gere {{N_QUESTOES}} questões de múltipla escolha no padrão {{BANCA}}, seguindo todas as regras abaixo.

---

## REGRAS INVIOLÁVEIS (válidas para todas as bancas)

### PRECISÃO FACTUAL
1. **NUNCA invente artigo de lei, prazo, percentual, número de súmula ou jurisprudência.**
2. Toda afirmação normativa deve decorrer do texto da teoria fornecida.
3. Se precisar citar dispositivo não presente na teoria, use `[VERIFICAR FONTE]`.
4. Use apenas legislação vigente até `{{DATA_LIMITE_LEG}}`.

### ESTRUTURA DAS QUESTÕES
1. **5 alternativas por questão:** Apenas 1 inequivocamente correta.
2. **Sem "todas as anteriores" ou "nenhuma das anteriores":** Essas opções são proibidas.
3. **Distratores plausíveis:** Nenhuma alternativa deve ser absurda ou obviamente errada — erros são sutis.
4. **Enunciado claro:** O que se pede deve ser inequívoco antes de ler as alternativas.
5. **Alternativas com comprimento similar:** Evitar que a mais longa seja sempre a correta.
6. **Cobertura:** Cada subtópico do plano deve ter pelo menos 1 questão.

---

## VARIAÇÕES POR BANCA

### 🔵 Padrão FCC

**Características obrigatórias:**
1. Enunciado direto e curto (1–2 linhas): "Assinale a alternativa correta sobre [tema]."
2. Sem caso fático longo — no máximo 2 linhas de contexto.
3. Alternativas com troca de conceito doutrinário clássico (Di Pietro, Meirelles, etc.).
4. 40% das questões cobram texto de lei literal.
5. Base doutrinária identificada no gabarito (autor clássico).
6. Questões de Exatas: dados numéricos completos no enunciado; resultado exato em uma das alternativas.

**Template FCC:**
```
[ENUNCIADO]
"Assinale a alternativa correta sobre [tema do edital]."
OU
"De acordo com [Lei X / [Autor]], é correto afirmar:"

[ALTERNATIVAS]
A) <Conceito correto com 1 detalhe trocado — prazo, sujeito ou adjetivo>
B) <Conceito de instituto similar>
C) <Afirmação correta mas incompleta — falta a condição/exceção>
D) <CORRETA — fiel ao texto de lei e ao autor clássico>
E) <Afirmação errada por troca de elemento legal>

[GABARITO] D
[AUTOR] <Di Pietro / Meirelles / Carvalho Filho — conforme a disciplina>
[LEI] <Art. X, Lei nº Y/AAAA>
```

---

### 🟣 Padrão FGV

**Características obrigatórias:**
1. Enunciado com situação fática (caso concreto — 3–6 linhas).
2. Pelo menos 2 alternativas "quase corretas" (sinônimos imperfeitos).
3. Cobra jurisprudência recente do STF/STJ (últimos 3–4 anos).
4. Questões interdisciplinares são bem-vindas.
5. Alternativas com linguagem doutrinária elevada (Barroso, Didier, Pacelli conforme área).
6. Enunciados podem pedir "CORRETA", "INCORRETA" ou "MELHOR RESPONDE".

**Template FGV:**
```
[SITUAÇÃO]
"[Nome], [qualidade/cargo], [ação praticada]. Considerando [base legal/doutrina], assinale a alternativa [correta/incorreta/que melhor responde]."

[ALTERNATIVAS]
A) <Incorreta — erro sutil: elemento trocado>
B) <Incorreta — erro grosseiro: fácil de eliminar>
C) <CORRETA — completa, precisa, com base doutrinária/jurisprudencial>
D) <Incorreta — sinônimo imperfeito da C: difere em 1 palavra crítica>
E) <Incorreta — inversão de regra/exceção>

[GABARITO] C
[FUNDAMENTO] <Lei/art. + Doutrina: Autor, Obra, ed., p.>
[JURISPRUDÊNCIA] <SE APLICÁVEL: STF/STJ — Tese/Súmula nº X>
[ANÁLISE DISTRATORES]
A) Errado porque: ...
B) Errado porque: ...
D) Errado porque: diferença de D para C é [aspecto] — C está correto porque [fundamento]
E) Errado porque: ...
```

---

### 🔴 Padrão VUNESP

**Características obrigatórias:**
1. 30–40% das questões devem pedir a alternativa **INCORRETA** (destacar INCORRETA em maiúsculas ou negrito).
2. Enunciado curto — máximo 2 linhas.
3. Alternativas quase idênticas — troca de 1 palavra-chave entre elas.
4. Base: texto literal da lei — artigo específico.
5. Sem caso fático extenso.
6. Para cargos do TJ-SP: incluir questões de Regimento Interno/Estatuto.

**Template VUNESP:**
```
[ENUNCIADO]
"Sobre [tema], assinale a alternativa **INCORRETA**."
OU
"De acordo com o art. X da Lei Y, é **CORRETO** afirmar que:"

[ALTERNATIVAS — com palavras-chave variando]
A) <Afirmação com elemento A — CORRETA (ou INCORRETA se pedir INCORRETA)>
B) <Afirmação com elemento B trocado>
C) <Afirmação com elemento C trocado>
D) <Afirmação com elemento D trocado — A SER MARCADA se "INCORRETA">
E) <Afirmação com elemento E trocado>

[GABARITO] D (se pede INCORRETA)
[ARTIGO] <Transcrição literal: "Art. X da Lei Y: ...">
[ARMADILHA] <Palavra trocada: "30 dias" no lugar de "15 dias">
```

---

### 🟢 Padrão CESGRANRIO

**Características obrigatórias:**
1. Todo item tem texto-base (texto, tabela ou gráfico — 100 a 300 palavras).
2. Enunciado integrado ao contexto: "Com base no texto acima...", "Considerando os dados..."
3. A resposta correta é paráfrase — não cópia do texto.
4. Questões interdisciplinares são esperadas.
5. Inglês técnico pode ser cobrado — incluir em concursos Petrobras/BB.
6. Distratores usam dados reais do texto de forma errada.

**Template CESGRANRIO:**
```
[TEXTO-BASE]
<150 a 300 palavras — texto informativo, tabela ou gráfico>
<Fonte: [autor/publicação fictícia mas verossímil]>

[ENUNCIADO]
"Com base no texto acima, [pergunta]."
OU
"Considerando o cenário descrito e os conceitos de [área], assinale a alternativa correta."

[ALTERNATIVAS]
A) <Incorreta — inferência indevida do texto>
B) <Incorreta — usa dado do texto de forma errada>
C) <CORRETA — paráfrase correta do texto + conceito técnico>
D) <Incorreta — conceito técnico errado aplicado aos dados corretos>
E) <Incorreta — inversão de relação causal>

[GABARITO] C
[FUNDAMENTO] <Parágrafo/frase do texto-base + conceito técnico>
```

---

### 🟡 Padrão IBFC / IDECAN / Bancas de Médio Porte

**Características:**
1. Enunciado simples e direto (1–2 linhas).
2. Distratores com erros mais explícitos que FCC/VUNESP.
3. 50% fácil, 40% médio, 10% difícil.
4. Sem texto-base longo.
5. Foco no conteúdo específico do cargo.

**Template IBFC:**
```
[ENUNCIADO]
"Assinale a alternativa correta sobre [tema]."

[ALTERNATIVAS]
A) <Conceito com detalhe errado>
B) <CORRETA>
C) <Conceito de instituto similar>
D) <Afirmação com prazo/número errado>
E) <Afirmação absurda — fácil de eliminar (1 por questão)>

[GABARITO] B
[FUNDAMENTO] <Lei/art. ou conceito básico>
```

---

## FORMATO DE SAÍDA COMPLETO

```json
{
  "aula": "{{TITULO_AULA}}",
  "banca": "{{BANCA}}",
  "total_questoes": {{N_QUESTOES}},
  "questoes": [
    {
      "id": "Q01",
      "tipo_enunciado": "CORRETA",
      "enunciado": "<texto do enunciado>",
      "situacao": "<situação fática se aplicável — null para FCC/VUNESP>",
      "texto_base": "<texto-base se CESGRANRIO — null para outros>",
      "alternativas": {
        "A": "<texto>",
        "B": "<texto>",
        "C": "<texto>",
        "D": "<texto>",
        "E": "<texto>"
      },
      "gabarito": "D",
      "nivel": "Médio",
      "subtopico": "<subtópico coberto>",
      "fundamento": "<Art. X, Lei Y / Autor, Obra>",
      "analise_distratores": {
        "A": "<por que A está errada>",
        "B": "<por que B está errada>",
        "C": "<por que C está errada>",
        "E": "<por que E está errada>"
      },
      "armadilha_principal": "<ARM_05 — prazo trocado | null>",
      "flag_revisao_humana": false,
      "motivo_revisao": null
    }
  ]
}
```

---

## Checklist de Qualidade — Questões ME

**Por questão:**
- [ ] Exatamente 5 alternativas
- [ ] Apenas 1 alternativa correta
- [ ] Enunciado claro sobre o que se pede (correta ou incorreta)
- [ ] Distratores plausíveis (sem opções absurdas, exceto 1 em bancas de menor rigor)
- [ ] Fundamento legal/doutrinário identificado
- [ ] Análise de distratores documentada (para questoes_comentadas.md)
- [ ] `flag_revisao_humana` preenchido

**Pelo lote:**
- [ ] Cobertura de todos os subtópicos do plano
- [ ] Distribuição de dificuldade conforme solicitado
- [ ] Proporção de "incorreta" conforme o padrão da banca
- [ ] Estilo consistente com a banca especificada
- [ ] JSON válido e completo
- [ ] Sem repetição de alternativa correta sempre na mesma posição (A, B, C, D, E — distribuir)

**Validação de alternativas:**
- [ ] Comprimento similar entre as alternativas (± 20% de variação)
- [ ] Sem "todas as anteriores" ou "nenhuma das anteriores"
- [ ] Sem alternativas que se excluam mutuamente de forma óbvia
- [ ] Linguagem uniforme entre todas as alternativas da mesma questão
