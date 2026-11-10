# Prompt A — Extração do Conteúdo Programático do Edital

## Metadados
- **Estágio do pipeline:** 1 — Extração de Escopo
- **Input:** Texto do edital (PDF convertido a texto ou URL do edital)
- **Output:** JSON estruturado com o conteúdo programático hierarquizado
- **Quando usar:** Imediatamente após obter o edital; antes de qualquer geração de conteúdo

---

## Instruções de Uso

### Quando usar este prompt
- Sempre que um novo edital for disponibilizado (`EDITAL_STATUS = publicado`)
- Quando uma retificação alterar o conteúdo programático
- Para validar o `PLAN.md` contra o edital real

### Como preencher os campos variáveis
Substitua os marcadores `{{...}}` antes de enviar o prompt:

| Marcador | O que inserir |
|---|---|
| `{{TEXTO_EDITAL}}` | Texto completo do edital (ou da seção de conteúdo programático) |
| `{{CONCURSO_NOME}}` | Nome do concurso (ex: "Concurso Público TJSP 2024") |
| `{{CARGO}}` | Cargo específico (ex: "Escrevente Técnico Judiciário") |
| `{{BANCA}}` | Nome da banca (ex: "VUNESP") |
| `{{DATA_LIMITE_LEG}}` | Data-limite de legislação do edital (ex: "01/01/2024") |

---

## O Prompt

```
Você é um especialista em análise de editais de concursos públicos brasileiros.

## DADOS DO CONCURSO
- Concurso: {{CONCURSO_NOME}}
- Cargo: {{CARGO}}
- Banca: {{BANCA}}
- Data-limite da legislação: {{DATA_LIMITE_LEG}}

## TAREFA
Analise o edital abaixo e extraia o conteúdo programático completo, estruturado em JSON.

## REGRAS OBRIGATÓRIAS
1. Extraia TODOS os itens do conteúdo programático, sem omissão.
2. Preserve a numeração original do edital (ex: "3.1", "II", "a)").
3. Identifique a disciplina de cada item.
4. Estime o peso relativo de cada disciplina com base no número de questões informado no edital.
5. Se o edital indicar autores ou obras obrigatórias, inclua-os.
6. Se algum item do edital for ambíguo, extraia-o como está e adicione uma nota de alerta.
7. NÃO invente itens. Se não estiver no edital, não inclua.
8. Responda APENAS com o JSON. Sem texto antes ou depois.

## FORMATO DE SAÍDA

```json
{
  "concurso": "{{CONCURSO_NOME}}",
  "cargo": "{{CARGO}}",
  "banca": "{{BANCA}}",
  "data_limite_legislacao": "{{DATA_LIMITE_LEG}}",
  "data_extracao": "YYYY-MM-DD",
  "total_questoes_prova": null,
  "penalizacao_erro": false,
  "nota_minima_geral": null,
  "nota_minima_por_disciplina": false,
  "etapas": ["Objetiva", "..."],
  "disciplinas": [
    {
      "id": "disc_01",
      "nome": "Língua Portuguesa",
      "numero_questoes": 20,
      "peso_percentual": 20.0,
      "nota_minima_disciplina": null,
      "referencias_bibliograficas": [],
      "itens": [
        {
          "id_edital": "1.1",
          "descricao": "Compreensão e interpretação de textos",
          "subtopicos": [
            "Significação das palavras",
            "Substituição de palavras ou trechos do texto"
          ],
          "nivel_profundidade_estimado": "alto",
          "alerta": null
        }
      ]
    }
  ],
  "alertas_gerais": [
    "Item 3.4 do edital usa linguagem ambígua — pode cobrir tanto X quanto Y"
  ],
  "referencias_bibliograficas_gerais": []
}
```

## EDITAL
{{TEXTO_EDITAL}}
```

---

## Exemplo de Saída Esperada

```json
{
  "concurso": "Concurso Público TJ-SP 2024",
  "cargo": "Escrevente Técnico Judiciário",
  "banca": "VUNESP",
  "data_limite_legislacao": "2024-03-01",
  "data_extracao": "2024-11-10",
  "total_questoes_prova": 85,
  "penalizacao_erro": false,
  "nota_minima_geral": 60.0,
  "nota_minima_por_disciplina": false,
  "etapas": ["Objetiva", "Avaliação de títulos"],
  "disciplinas": [
    {
      "id": "disc_01",
      "nome": "Língua Portuguesa",
      "numero_questoes": 20,
      "peso_percentual": 23.5,
      "nota_minima_disciplina": null,
      "referencias_bibliograficas": [],
      "itens": [
        {
          "id_edital": "1",
          "descricao": "Compreensão e interpretação de textos de gêneros variados",
          "subtopicos": [
            "Reconhecimento de tipos e gêneros textuais",
            "Domínio do léxico: emprego de palavras e expressões no contexto",
            "Domínio da ortografia oficial"
          ],
          "nivel_profundidade_estimado": "alto",
          "alerta": null
        },
        {
          "id_edital": "2",
          "descricao": "Domínio dos mecanismos de coesão textual",
          "subtopicos": [
            "Emprego de elementos de referenciação, substituição e repetição",
            "Emprego de conectores"
          ],
          "nivel_profundidade_estimado": "médio",
          "alerta": null
        }
      ]
    },
    {
      "id": "disc_02",
      "nome": "Direito Constitucional",
      "numero_questoes": 10,
      "peso_percentual": 11.8,
      "nota_minima_disciplina": null,
      "referencias_bibliograficas": [],
      "itens": [
        {
          "id_edital": "3.1",
          "descricao": "Constituição Federal de 1988: princípios fundamentais",
          "subtopicos": [],
          "nivel_profundidade_estimado": "médio",
          "alerta": null
        },
        {
          "id_edital": "3.2",
          "descricao": "Direitos e garantias fundamentais",
          "subtopicos": [
            "Direitos individuais e coletivos",
            "Direitos sociais",
            "Direitos políticos"
          ],
          "nivel_profundidade_estimado": "alto",
          "alerta": "Item amplo — verificar se o edital especifica quais incisos do art. 5º são prioritários"
        }
      ]
    }
  ],
  "alertas_gerais": [
    "O edital menciona 'legislação correlata' em Direito Administrativo sem especificar quais leis — inferir com base no cargo"
  ],
  "referencias_bibliograficas_gerais": []
}
```

---

## Variações para Modo Pré-Edital

### Quando usar
Quando `EDITAL_STATUS = previsto` e não há edital disponível.

### Prompt Adaptado (Modo B — Pré-Edital)

```
Você é um especialista em análise de editais de concursos públicos brasileiros.

## DADOS DO CONCURSO
- Concurso: {{CONCURSO_NOME}} (EDITAL AINDA NÃO PUBLICADO)
- Cargo: {{CARGO}}
- Banca: {{BANCA}}
- Data prevista de publicação: {{DATA_PREVISTA}}

## FONTES DISPONÍVEIS
{{#if EDITAIS_ANTERIORES}}
- Editais anteriores do mesmo órgão/cargo: {{EDITAIS_ANTERIORES}}
{{/if}}
{{#if ORGAOS_ANALOGOS}}
- Órgãos análogos para referência: {{ORGAOS_ANALOGOS}}
{{/if}}

## TAREFA
Com base nas fontes disponíveis, infira o conteúdo programático mais provável para este concurso.

## REGRAS OBRIGATÓRIAS
1. Para CADA item inferido, indique a fonte da inferência.
2. Classifique cada item com um dos marcadores:
   - "INFERIDO_EDITAL_ANTERIOR" — apareceu em edital anterior do mesmo órgão/cargo
   - "INFERIDO_ORGAO_ANALOGO" — aparece em editais de órgãos similares
   - "LEGISLACAO_OBRIGATORIA" — legislação estruturante da área (todo edital cobra)
   - "HISTORICO_BANCA" — cobrado frequentemente pela banca para o perfil do cargo
3. Atribua uma probabilidade (0–100%) de o item aparecer no edital real.
4. Inclua uma seção de "alertas" para premissas críticas.
5. NÃO afirme como certo o que é inferido.
6. Responda APENAS com o JSON no mesmo formato padrão, com campos adicionais de pré-edital.

## FORMATO ADICIONAL PARA PRÉ-EDITAL
Adicione em cada item:
```json
{
  "pre_edital": {
    "status": "INFERIDO_EDITAL_ANTERIOR",
    "fonte": "Edital TJ-SP 2022, item 3.2",
    "probabilidade_aparecimento": 85,
    "observacao": "Apareceu nos últimos 3 editais do TJ-SP"
  }
}
```
```

### Pós-Publicação do Edital (Atualização do JSON Pré-Edital)
Quando o edital for publicado, execute novamente o **Prompt A no modo padrão** e compare com o JSON pré-edital:
1. Identifique itens novos (não previstos)
2. Identifique itens removidos (previstos mas não cobrados)
3. Identifique itens com alteração de profundidade
4. Atualize o `PLAN.md` e registre no `HISTORY.md`

---

## Checklist de Validação da Extração

Após receber o JSON, verifique:

- [ ] Número total de disciplinas no JSON = número no edital
- [ ] Soma dos pesos percentuais ≈ 100%
- [ ] Todos os itens com `id_edital` preenchido
- [ ] Alertas gerados para itens ambíguos
- [ ] `data_limite_legislacao` preenchida
- [ ] `penalizacao_erro` verificado no edital
- [ ] `nota_minima_geral` e `nota_minima_por_disciplina` preenchidos
- [ ] JSON válido (sem erros de sintaxe)
