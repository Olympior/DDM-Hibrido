# Relatório de Validação de Requisitos


## 1. Resultados do Checklist

| Critério                     | Avaliação | Problemas Identificados                                                                 | Ações Recomendadas                                                                 |
|------------------------------|-----------|-----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| **1. Estrutura e Identificação** | ✔         | -                                                                                       | -                                                                                 |
| **2. Clareza e Linguagem**       | ✖         | - CDU07: "salvá-lo ou compará-lo" ambíguo<br>- CDU09: Campos editáveis não especificados| - Reescrever CDU07<br>- Especificar campos editáveis em CDU09                     |
| **3. Consistência e Conflitos**  | ✔         | -                                                                                       | -                                                                                 |
| **4. Completude**                | ✖         | - Falta fluxo alternativo em CDU07<br>- Faltam requisitos não-funcionais                | - Adicionar tratamento de erro<br>- Criar seção de requisitos não-funcionais      |
| **5. Qualidade Técnica**         | ✖         | - CDU01 sem critério de aceitação                                                       | - Adicionar critérios de teste                                                    |
| **6. Padrões e Referências**     | ✔         | -                                                                                       | -                                                                                 |
| **7. Validação Externa**         | ✖         | - Não revisado por stakeholders<br>- Sem priorização                                    | - Agendar sessão de validação<br>- Aplicar método MoSCoW                          |
| **8. Conformidade**              | ✖         | - Não menciona LGPD                                                                     | - Adicionar política de privacidade                                               |

---

## 2. Problemas Críticos e Ações Prioritárias

| Prioridade | Problema                              | Ação                                                                                   |
|------------|---------------------------------------|----------------------------------------------------------------------------------------|
| Alta       | Ambiguidade em CDU07 e CDU09          | Revisar redação e adicionar regras específicas                                         |
| Alta       | Falta requisitos não-funcionais       | Incluir NF01 (performance) e NF02 (armazenamento)                                      |
| Média      | Termos não definidos                  | Criar glossário com "volume/peso" e "código de barras"                                 |
| Baixa      | Ausência de priorização               | Classificar requisitos com método MoSCoW                                               |

---

## 3. Checklist Detalhado

| Critério       | CDU01 | CDU02 | CDU03 | CDU04 | CDU05 | CDU06 | CDU07 | CDU08 | CDU09 | CDU10 |
|----------------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| **Estrutura**  | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     |
| **Clareza**    | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✖     | ✔     | ✖     | ✔     |
| **Consistência**| ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     | ✔     |
| **Completude** | ✖     | ✔     | ✔     | ✔     | ✔     | ✔     | ✖     | ✔     | ✔     | ✔     |

---

## 4. Conclusão e Próximos Passos

**Pontos Fortes:**
- Estrutura bem organizada
- Consistência entre requisitos

**Pontos Fracos:**
- Ambiguidades em alguns requisitos
- Falta de requisitos não-funcionais

**Ações:**
1. Corrigir ambiguidades nos requisitos problemáticos
2. Adicionar seção de requisitos não-funcionais
3. Realizar sessão de validação com stakeholders
4. Priorizar requisitos usando método MoSCoW

**Artefatos para Atualizar:**
- Documento de Requisitos v2.0
- Glossário de Termos
- Diagramas de Caso de Uso