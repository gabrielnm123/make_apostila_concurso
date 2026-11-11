# Prompt F — Comentário de Questão (Gabarito Comentado)

## Metadados
- **Estágio do pipeline:** 5 — Comentário de Questões
- **Input:** JSON de questões (saídas dos Prompts D ou E) + teoria da aula
- **Output:** Arquivo `questoes_comentadas.md` com análise completa de cada questão
- **Quando usar:** Após gerar as questões (Prompts D ou E); para transformar `questoes_treino.md` em `questoes_comentadas.md`

---

## Instruções de Uso

### Quando usar este prompt
- Sempre, para toda aula — o arquivo `questoes_comentadas.md` é obrigatório
- Para comentar questões de provas anteriores (questões reais da banca)
- Para gerar gabaritos comentados de simulados

### Como preencher os campos variáveis

| Marcador | O que inserir |
|---|---|
| `{{JSON_QUESTOES}}` | JSON completo das questões (saída dos Prompts D ou E) |
| `{{TEORIA_AULA}}` | Texto da teoria (para referência de fundamento) |
| `{{BANCA}}` | Nome da banca |
| `{{CARGO}}` | Cargo |
| `{{DISCIPLINA}}` | Disciplina |
| `{{TITULO_AULA}}` | Título da aula |

---

## O Prompt

```
Você é um professor especialista em concursos públicos, comentarista de questões da banca {{BANCA}}, com profundo conhecimento de {{DISCIPLINA}}.

## CONTEXTO
- Disciplina: {{DISCIPLINA}}
- Aula: {{TITULO_AULA}}
- Cargo: {{CARGO}}
- Banca: {{BANCA}}

## QUESTÕES A COMENTAR
{{JSON_QUESTOES}}

## TEORIA DE REFERÊNCIA
{{TEORIA_AULA}}

---

## TAREFA
Produza o arquivo `questoes_comentadas.md` com comentário completo de cada questão.

---

## REGRAS DO COMENTÁRIO

### REGRAS DE PRECISÃO
1. Cite a fonte legal exata (lei, artigo, parágrafo, inciso) para cada afirmação.
2. Nunca afirme como "errado" algo que seja discutível doutrinariamente sem alertar.
3. Se o gabarito de uma questão real (de prova oficial) for questionável, indique `⚠️ GABARITO DISCUTÍVEL` e explique os dois lados.
4. Use `[VERIFICAR FONTE]` para qualquer afirmação que não esteja confirmada no material fornecido.

### REGRAS PEDAGÓGICAS DO COMENTÁRIO
1. **Gabarito imediato:** A resposta (C/E ou letra) no início do comentário.
2. **Fundamento legal:** Cite a fonte normativa antes de qualquer explicação.
3. **Por que a correta está certa:** Explique claramente por que o gabarito é correto.
4. **Análise de cada alternativa incorreta:** Para múltipla escolha, explique o erro de CADA alternativa.
5. **Padrão da banca:** Identifique qual armadilha ou técnica a banca usou.
6. **Cuidado para a prova:** Uma dica objetiva para o candidato não errar questão similar.
7. **Versão correta (C/E):** Para itens ERRADO, reescreva o item de forma correta.

### REGRAS DE ESTILO
1. Linguagem direta e didática — como um professor explicando em aula.
2. Sem floreios: "Esta questão cobra..." em vez de "Esta maravilhosa questão..."
3. Boxes de alerta nos pontos de pegadinha.
4. Comprimento proporcional à dificuldade — questão fácil = comentário curto; difícil = comentário detalhado.

---

## FORMATO DE SAÍDA

```markdown
# Questões Comentadas — {{TITULO_AULA}}
**Disciplina:** {{DISCIPLINA}} | **Banca:** {{BANCA}} | **Cargo:** {{CARGO}}

---

## Questão 01

**Enunciado:**
> <Texto completo do item ou da questão com suas alternativas>

**Gabarito:** <CERTO | ERRADO | Letra X>

---

### 📋 Fundamento Legal
<Art. X, §Y, inciso Z, Lei nº XXXX/AAAA — transcrição literal ou resumo fiel>
<Súmula nº X do [Tribunal] — enunciado>
<Doutrina: Autor, Obra, ed., p. — se aplicável>

---

### ✅ Por que o Gabarito está Correto

<Explicação direta de por que a alternativa correta é correta.
Para C/E: por que a afirmação é verdadeira / por que é falsa.
Para ME: por que a alternativa X responde ao enunciado.>

---

### ❌ Análise de Cada Alternativa *(apenas para Múltipla Escolha)*

**Alternativa A — ERRADA**
> <Texto da alternativa A>
<Explicação: qual é o erro? O que deveria estar escrito para ser correto?>

**Alternativa B — ERRADA**
> <Texto da alternativa B>
<Explicação...>

**Alternativa C — CORRETA**
> <Texto da alternativa C>
<Confirmação: por que C está correta — fundamento.>

**Alternativa D — ERRADA**
> <Texto da alternativa D>
<Explicação — se sinônimo imperfeito de C, destacar a diferença crítica.>

**Alternativa E — ERRADA**
> <Texto da alternativa E>
<Explicação...>

---

### 🎯 Padrão da Banca Usado

> ⚠️ **PEGADINHA {{BANCA}}:** <nome da armadilha + descrição de como a banca a aplicou nesta questão>

<Exemplos de itens similares que a banca já fez (se disponível na teoria)>

---

### ✍️ Versão Correta do Item *(apenas para C/E com gabarito ERRADO)*

> <Reescreva o item de forma que fique CERTO, sublinhando a correção>

---

### 💡 Cuidado para a Prova

> 📌 **DICA:** <O que o candidato deve fazer ao ver questões similares — dica objetiva em 1–2 linhas>

---

### 📊 Metadados
| Campo | Valor |
|---|---|
| Nível de dificuldade | <Fácil / Médio / Difícil> |
| Subtópico | <nome> |
| Armadilha usada | <código + nome> |
| Flag revisão humana | <SIM / NÃO> |
| Motivo revisão | <motivo se SIM> |

---

## Questão 02
[...]
```

---

## Variações por Banca

### Variação CEBRASPE — Foco no C/E

Adicione ao comentário de cada item ERRADO:

```markdown
### 🔄 Transformação do Item

| | Texto |
|---|---|
| **Item original (ERRADO)** | <texto com a pegadinha sublinhada> |
| **Item corrigido (CERTO)** | <texto corrigido com a correção em negrito> |
| **Elemento modificado** | <"180 dias" → "120 dias" / "revogação" → "anulação"> |
```

### Variação FGV — Foco na Situação Fática

Adicione ao comentário:

```markdown
### ⚖️ Raciocínio Jurídico Aplicado

**Fatos relevantes da situação:**
1. <Fato 1 — relevante para a solução>
2. <Fato 2 — relevante>
3. <Fato N — distrator — irrelevante para a solução>

**Subsunção:**
<Os fatos relevantes se enquadram na hipótese do Art. X porque...>

**Conclusão:**
<Portanto, a consequência jurídica é Y, o que corresponde à alternativa C.>
```

### Variação VUNESP — Foco na Literalidade

Adicione ao comentário:

```markdown
### 📖 Texto Legal de Referência

**O artigo diz:**
> *"Art. X: [transcrição literal]"*

**A alternativa incorreta diz:**
> *"[texto da alternativa com erro sublinhado]"*

**Diferença:** <palavra certa × palavra errada>
```

### Variação CESGRANRIO — Foco no Texto-Base

Adicione ao comentário:

```markdown
### 🔍 Localização no Texto-Base

**Parágrafo de referência:**
> *"[trecho do texto-base que sustenta o gabarito]"*

**Paráfrase correta:**
<A alternativa C parafraseia corretamente esse trecho ao afirmar que...>

**Por que as outras alternativas falham:**
<A e B usam dados do texto mas os interpretam erroneamente ao...>
```

---

## Questões Reais de Provas Anteriores — Instruções Especiais

Quando o input for uma questão real de prova oficial (não gerada pelo pipeline):

1. **Adicione o cabeçalho:**
   ```
   > 📌 **Questão Real** — {{BANCA}}, {{CARGO}}, Ano {{ANO}}
   ```

2. **Nunca altere o texto da questão original** — comente sem modificar.

3. **Se o gabarito oficial for discutível:**
   ```markdown
   > ⚠️ **GABARITO DISCUTÍVEL**
   > O gabarito oficial é [X], mas há argumentos para [Y]:
   > - Argumento a favor de [X]: ...
   > - Argumento a favor de [Y]: ...
   > **Recomendação:** Em prova, marque [X] (gabarito oficial). Esteja ciente da controvérsia.
   ```

4. **Registre recursos históricos conhecidos:**
   ```markdown
   > ℹ️ **HISTÓRICO DE RECURSOS:** Esta questão gerou [X] recursos na prova original. 
   > A banca [manteve/alterou] o gabarito por [motivo].
   ```

---

## Checklist de Qualidade — Comentários

**Por questão:**
- [ ] Gabarito explicitado no início
- [ ] Fundamento legal com artigo específico
- [ ] Explicação do por que a correta está certa
- [ ] Análise de TODAS as alternativas incorretas (ME) ou versão correta (C/E)
- [ ] Pegadinha/padrão da banca identificado
- [ ] Dica objetiva ao final
- [ ] Metadados preenchidos
- [ ] `[VERIFICAR FONTE]` marcado quando necessário

**Pelo arquivo:**
- [ ] Questões em ordem numérica
- [ ] Cabeçalho com disciplina, banca e cargo
- [ ] Nenhum comentário em branco ou genérico demais
- [ ] Questões discutíveis marcadas com `⚠️ GABARITO DISCUTÍVEL`
- [ ] Questões reais identificadas com cabeçalho de proveniência
- [ ] **Autossuficiência textual:** redação em estilo de livro ("Esta seção analisa...", "como visto na teoria anterior", e nunca "este arquivo analisa..." ou referências a nomes de arquivos `.md`)
