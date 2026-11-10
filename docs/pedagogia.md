# Princípios Pedagógicos — make_apostila_concurso

> Este documento define os princípios de ciência cognitiva e design instrucional que devem guiar **toda** a geração de conteúdo. O agente deve internalizá-los e aplicá-los em cada decisão de estrutura, linguagem e sequência.

---

## 1. Os Sete Princípios Fundamentais

### 1.1 Recuperação Ativa (Active Recall)

**O que é:** testar-se é mais eficaz do que reler ou sublinhar. O ato de recuperar informação da memória fortalece a retenção muito mais do que o reconhecimento passivo.

**Evidência:** décadas de pesquisa em psicologia cognitiva (Roediger & Karpicke, 2006; Cepeda et al.) mostram que uma sessão de teste produz retenção superior a múltiplas releituras.

**Como aplicar na apostila:**
- Inserir `❓ CHECKPOINT` no meio da teoria (não só no final)
- Questões de fixação curtas após cada subtópico
- Flashcards com pergunta na frente, resposta no verso
- Nunca apresentar o gabarito na mesma página das questões de treino
- Boxes "Responda antes de continuar" antes de revelar definições

**Erros a evitar:**
- Apostila apenas narrativa sem momentos de teste
- Questões só no final do capítulo (distância grande da teoria → menor retenção)

---

### 1.2 Repetição Espaçada

**O que é:** revisar o conteúdo em intervalos crescentes, aproveitando o momento certo em que o esquecimento está quase ocorrendo (Curva do Esquecimento de Ebbinghaus, 1885).

**Intervalos recomendados:** D+1 → D+3-7 → D+15-30 → mensal

**Sistema de Leitner:** três caixas de flashcards — caixa 1 (errou), caixa 2 (acertou uma vez), caixa 3 (acertou consistentemente). Revisar caixa 1 todo dia, caixa 2 a cada 3 dias, caixa 3 semanalmente.

**Como aplicar na apostila:**
- Cada resumo termina com:
  ```
  ## Revisão Espaçada
  - D+1: releia este resumo (5 min)
  - D+7: refaça as questões de treino
  - D+30: refaça o flashcard deck desta aula
  ```
- Flashcards `.csv` exportáveis para Anki (que implementa o algoritmo SM-2)
- Sumário de revisão por "cartão de revisão" (1 página por aula)
- O `plano_de_estudo.md` deve incluir revisões programadas

---

### 1.3 Prática Supera Leitura

**O que é:** a proporção ideal de tempo é 60-70% em questões e revisão ativa, 30-40% em leitura de teoria.

**Implicação editorial:** uma apostila com 80% de texto e 20% de questões está invertida. O volume de questões comentadas deve ser proporcional ou superior ao volume de teoria.

**Como aplicar:**
- Mínimo de `APOSTILA_QUESTOES_MIN_POR_TOPICO` questões por tópico (configurável no `.env`)
- Questões no meio da teoria (`❓ CHECKPOINT`), não só ao final
- O resumo é tão importante quanto a teoria — é o instrumento de revisão ativa
- Simulado final proporcional à prova real

---

### 1.4 Intercalação (Interleaving)

**O que é:** alternar temas e disciplinas em vez de estudar um bloco monolítico. Produz aprendizagem mais durável, mesmo que pareça menos eficiente no curto prazo.

**Como aplicar:**
- O `plano_de_estudo.md` deve distribuir disciplinas ao longo da semana, não concentrar uma por vez
- Sugerir ciclos de estudo: 50 min de disciplina A → 10 min pausa → 50 min de disciplina B
- Questões do simulado final misturar disciplinas (como a prova real)

---

### 1.5 Elaboração e Conexão de Conceitos

**O que é:** conectar o novo conteúdo a conhecimentos anteriores, criar analogias, perguntar "por que?" e "como se relaciona com X?".

**Como aplicar:**
- Boxes `🔍 NÃO CONFUNDA` para diferenciações conceituais (maior impacto quando o candidato já conhece os dois lados)
- Referências cruzadas entre aulas ("veja também: Aula 03, item 2.1")
- Exemplos concretos e casos fáticos — especialmente importante para FGV
- Tabelas comparativas que forçam a articulação de diferenças

---

### 1.6 Controle de Carga Cognitiva

**O que é:** a memória de trabalho é limitada. Excesso de informação simultânea bloqueia a aprendizagem (Sweller, 1988). Sinalização visual reduz a carga extrínseca e libera capacidade para processamento do conteúdo.

**Como aplicar:**
- Boxes com ícones padronizados (📌 🔍 ⚠️ ⚖️ 🧠 📋 ❓) — um símbolo = um significado, sempre
- Tabelas para comparações (menos texto, mais estrutura)
- Frases curtas, parágrafos curtos (máx. 5 linhas)
- Progressão do simples ao complexo dentro de cada aula
- Nunca apresentar três conceitos novos no mesmo parágrafo sem exemplo

**Tipografia (para geração de PDF/DOCX):**
- Fonte legível, tamanho mínimo 11pt para texto, 9pt para tabelas
- Contraste adequado (texto escuro em fundo claro)
- Espaçamento entre linhas ≥ 1.3

---

### 1.7 Feedback Imediato

**O que é:** a correção imediata do erro é mais eficaz do que a correção postergada.

**Como aplicar:**
- Questões comentadas com análise de **cada** alternativa (não só o gabarito)
- O comentário deve explicar *por que o distrator atrai* (não só "está errada")
- Boxes `⚠️ ATENÇÃO — PEGADINHA` inseridos no ponto exato da teoria onde o erro ocorreria
- Gabarito das questões de treino: nunca na mesma página, mas acessível na próxima seção

---

## 2. Taxonomia de Bloom — Objetivos de Aprendizagem

Cada aula deve ter um objetivo de aprendizagem explícito com verbo de Bloom adequado ao nível esperado na prova:

| Nível | Verbos | Quando usar |
|---|---|---|
| **Lembrar** | identificar, listar, reconhecer, nomear | Letra de lei, prazos, percentuais (VUNESP, FCC) |
| **Compreender** | explicar, descrever, interpretar, distinguir | Conceitos, princípios, jurisprudência (CEBRASPE) |
| **Aplicar** | aplicar, resolver, calcular, usar | Questões com situação-problema (FGV, CESGRANRIO) |
| **Analisar** | analisar, comparar, diferenciar, examinar | Diferenciações, casos fáticos complexos (FGV) |
| **Avaliar** | julgar, criticar, defender, avaliar | Discursivas, questões de alta dificuldade |
| **Criar** | elaborar, propor, construir | Redação, discursiva (FCC, FGV) |

**Regra prática:** a maioria dos concursos de nível médio opera nos níveis 1-2; nível superior e cargos fiscais operam nos níveis 2-4; discursivas operam nos níveis 4-6.

---

## 3. Linguagem e Redação Didática

### 3.1 Princípios de Linguagem Simples
- Frases curtas (máx. 2 orações por período)
- Voz ativa preferencial ("a lei exige" em vez de "é exigido pela lei")
- Termos técnicos sempre definidos na primeira ocorrência
- Sem jargão sem explicação
- Sem perífrases desnecessárias

### 3.2 Tom Dialógico
- Redigir como quem explica pessoalmente: "observe que", "atenção para", "veja bem"
- Sem infantilizar: o tom é de colega especialista, não de professor do ensino fundamental
- Usar "você" para criar engajamento

### 3.3 Progressão em Espiral
- Revisitar o mesmo tema em níveis crescentes ao longo da apostila
- Primeira aparição: conceito básico e exemplo simples
- Aparições subsequentes: nuances, exceções, casos difíceis

### 3.4 Generalizações
- **Nunca** usar "sempre", "nunca", "qualquer", "todo", "nenhum" sem base legal explícita
- Quando a banca usa esses termos como pegadinha: alertar no box ⚠️
- Preferir: "em regra", "como regra geral", "salvo exceção prevista em lei"

---

## 4. Estrutura de Questões — Princípios de Avaliação

### 4.1 Critérios de um Bom Item

| Critério | O que verificar |
|---|---|
| **Univocidade** | Há somente uma resposta claramente correta? |
| **Plausibilidade dos distratores** | Cada distrator representa um erro real de candidato? |
| **Paralelismo gramatical** | Alternativas paralelas em estrutura e extensão? |
| **Ausência de pistas** | A alternativa mais longa não é sistematicamente o gabarito? |
| **Enunciado completo** | O item faz sentido sem precisar ler as alternativas? |
| **Dificuldade adequada** | Índice de dificuldade alvo: 0,30–0,80 (30-80% de acertos) |

### 4.2 Distratores de Qualidade

Um distrator de qualidade representa um erro que candidatos **realmente** cometem:
- Confusão entre conceitos similares (nulidade × anulabilidade)
- Inversão de sujeito/competência
- Troca de prazo ou percentual próximo
- Esquecimento de exceção legal
- Generalização indevida de regra parcial

Distratores **inaceitáveis**:
- Absurdos óbvios que ninguém escolheria
- Erros de digitação como armadilha
- Alternativas que são claramente subconjuntos ou superconjuntos da correta sem distinção clara

### 4.3 Proporção de Dificuldade por Capítulo

| Nível | Proporção | Propósito |
|---|---|---|
| Fácil (acerto > 70%) | 30% | Fixação, confiança |
| Médio (acerto 40-70%) | 50% | Padrão da prova real |
| Difícil (acerto < 40%) | 20% | Diferenciação, desafio |

---

## 5. Meta-Estudo — Componentes que Aumentam a Eficácia

Inclua nas seções frontais (`00_front/`):

### `plano_de_estudo.md`
- Calcular dias disponíveis até a prova (se data conhecida)
- Distribuir disciplinas por semana com revisões programadas
- Incluir "semana de simulado" na penúltima semana
- Última semana: só revisão de resumos e flashcards, sem conteúdo novo

### `guia_da_banca.md`
- Perfil psicológico da prova: "o que a banca quer ver"
- Estratégia de gestão de tempo na prova
- Quando deixar em branco (CEBRASPE: calcular break-even)
- Erros mais comuns de candidatos nesta banca
- Checklist do dia da prova

### Caderno de Erros (template em `como_usar.md`)
```markdown
| Data | Disciplina | Questão | Meu Erro | Fundamento Correto | Revisado em |
|---|---|---|---|---|---|
```

---

## 6. Adaptação por Perfil de Candidato

O `.env` define o `CONCURSO_NIVEL` (superior/médio/fundamental). Ajuste:

| Variável | Nível Superior | Nível Médio |
|---|---|---|
| Profundidade da teoria | Completa + jurisprudência | Conceitual + letra de lei |
| Complexidade das questões | Níveis 2-4 de Bloom | Níveis 1-2 de Bloom |
| Uso de doutrina | Sim (mencionar autor) | Não (focar na lei) |
| Complexidade dos exemplos | Casos fáticos elaborados | Situações do cotidiano |
| Volume de flashcards | Maior (terminologia técnica) | Menor (conceitos-chave) |

---

## 7. Rastreabilidade Factual — A Regra de Ouro

> **Toda afirmação normativa é uma responsabilidade.**
> Um candidato que estuda informação errada pode perder o concurso.

**Hierarquia de fontes (da mais à menos confiável):**
1. Texto literal da lei (Planalto.gov.br, Diários Oficiais)
2. Súmulas vinculantes e precedentes obrigatórios (STF, STJ)
3. Informativos e acórdãos dos tribunais
4. Doutrina majoritária (livros indicados no edital têm prioridade)
5. Doutrina secundária (outros autores reconhecidos)
6. Inferência do agente ← **somente se marcado como `[VERIFICAR FONTE]`**

**Regra:** o agente nunca deve afirmar uma norma sem citar a fonte. Se não tem a fonte, marca e continua. O usuário revisa os marcadores antes de publicar.
