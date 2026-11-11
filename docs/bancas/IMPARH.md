# Perfil de Banca — IMPARH (Instituto Municipal de Desenvolvimento de Recursos Humanos)

> **Banca configurada no `.env` deste projeto** (`BANCA_NOME="IMPARH"`).
> Perfil construído em modo pré-edital, a partir de seleções anteriores do IMPARH para a Prefeitura
> de Fortaleza e de características públicas da banca. Itens marcados `[VERIFICAR]` devem ser
> confirmados quando o edital oficial for publicado.

---

## 1. Visão Geral

| Atributo | Valor |
|---|---|
| Nome completo | Instituto Municipal de Desenvolvimento de Recursos Humanos (IMPARH) |
| Natureza | Autarquia municipal de Fortaleza/CE — executa concursos e seleções do Município |
| Esfera de atuação | Municipal (predominante): Prefeitura de Fortaleza e órgãos vinculados |
| Formato observado | Múltipla escolha, **4 ou 5 alternativas** conforme o edital `[VERIFICAR]` |
| Penalização por erro | Não observada nas provas analisadas |
| Nível de dificuldade | Médio — cobertura ampla, pouca pegadinha "gramatical" |
| Destaques | Língua Portuguesa e legislação de saúde com peso alto em cargos da área |

> **Fonte:** página oficial de concursos da Prefeitura de Fortaleza
> (concursos.fortaleza.ce.gov.br) e levantamento público de características do IMPARH.
> O número de alternativas **varia por edital** e deve ser confirmado no edital 001/2026.

---

## 2. Características da Prova

1. **Cobertura ampla do conteúdo programático.** O IMPARH tende a cobrar muitos tópicos do edital
   com profundidade moderada em cada um. Por isso, **cobertura 100% é estratégica** — o risco maior
   do candidato é deixar tópico sem estudar, não deixar de aprofundar um tópico.
2. **Enunciados diretos.** Questões curtas, sem texto-base extenso. Situações-problema aparecem,
   mas raramente com caso fático longo.
3. **Língua Portuguesa com peso significativo.** Em seleções organizadas pelo próprio IMPARH, é
   comum a prova ter metade ou mais das questões de Português `[VERIFICAR no edital]`.
4. **Legislação de saúde recorrente.** Para cargos de saúde, a cobrança de Lei 8.080/1990,
   Lei 8.142/1990, Lei 11.350/2006 e PNAB é frequente.
5. **Conhecimentos gerais com viés local.** Atualidades e realidade municipal (Fortaleza/Ceará).

---

## 3. Padrão de Questões

1. **Conceito direto:** "Assinale a alternativa correta sobre X" — o conceito é o próprio conteúdo.
2. **Letra de lei:** cobra dispositivos de forma mais fiel que bancas que priorizam doutrina.
3. **Interpretação de texto:** textos informativos e jornalísticos de dificuldade média.
4. **Conhecimentos específicos:** atribuições, competências e procedimentos do cargo.
5. **Distratores por troca de detalhe:** número, prazo, sujeito, órgão competente, "sempre/nunca".

### Template de item (genérico)

```
Enunciado: "Sobre [tema], assinale a alternativa correta."
A) <Definição correta com um detalhe trocado>
B) <Definição correta>  ← GABARITO
C) <Instituto/conceito similar, trocado>
D) <Definição com número, prazo ou sujeito alterado>
E) <Afirmação generalizante esvaziada ("sempre", "nunca", "todo")>
```

---

## 4. Armadilhas Típicas do IMPARH

| Tipo | Exemplo | Como se proteger |
|---|---|---|
| Troca de competência | atribuir ao Município o que é da União (ou vice-versa) | memorizar a repartição constitucional de competências |
| Troca de número | alterar nº de pessoas por ACS, prazos, percentuais | memorizar só números com fonte confirmada |
| Generalização | "sempre", "nunca", "exclusivamente", "todo" | desconfiar de afirmação absoluta |
| Instituto vizinho | atribuição de ACS × atribuição de ACE | comparar em tabela |
| Sinônimo técnico errado | "vigilância sanitária" × "vigilância epidemiológica" | diferenciar os conceitos |
| Formato negativo | "assinale a INCORRETA" | grifar a palavra-chave no enunciado |

> 🔍 **NÃO CONFUNDA:** vigilância **epidemiológica** (doenças e agravos na população) ≠ vigilância
> **sanitária** (riscos em produtos, serviços e ambientes). O IMPARH cobra essa diferença.

---

## 5. Como Adaptar Questões para o IMPARH

- **Tom:** objetivo e direto; enunciado de 1–3 linhas.
- **Dificuldade:** 50% fácil, 40% médio, 10% difícil.
- **Alternativas:** 5 (conforme `.env`), com 1 correta e 4 distratores plausíveis.
- **Cobertura:** cobrir todos os itens do edital, sem verticalização excessiva.
- **Português:** textos informativos; gramática normativa básica a intermediária.
- **Legislação:** priorizar o texto de lei nacional (Planalto, MS) e a norma técnica vigente.
- **Nunca** usar pegadinha gratuita (erro de digitação como armadilha).

---

## 6. Gestão de Prova (sem penalização)

Como não há penalização por erro nas provas analisadas:

1. **Responda todas as questões.** Deixar em branco não traz benefício.
2. **Primeira passada:** resolva o que sabe com segurança.
3. **Segunda passada:** volte às duvidosas e elimine distratores.
4. **Últimos 10 minutos:** revisar marcações e conferir o cartão-resposta.

---

## 7. Aplicação neste projeto

| Uso | Onde |
|---|---|
| Formato dos itens (5 alternativas) | `questoes_treino.md`, `questoes_comentadas.md` |
| Dificuldade 50/40/10 | Estágio 7 do pipeline (`docs/pipeline.md`) |
| Cobertura 100% do edital | Estágio 1 (tabela de cobertura no `PLAN.md`) |
| Ausência de penalização | `00_front/guia_da_banca.md` |

> **Alerta de precisão:** o IMPARH alterna entre 4 e 5 alternativas conforme o edital. Este projeto
> usa `.env` → `BANCA_FORMATO_OBJETIVO="multipla_escolha_5"`. Se o edital 001/2026 trouxer 4
> alternativas, ajuste o `.env` e regere os itens.
