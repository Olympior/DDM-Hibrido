# Análise de Requisitos do Projeto

## 1. Problemas Identificados

### Lista de Verificação

| Critério de Análise          | CDU01 | CDU02 | CDU03 | CDU04 | CDU05 | CDU06 | CDU07 | CDU08 | CDU09 | CDU10 |
|------------------------------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| **Prematuro**                | 0     | 0     | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     |
| **Combinados**               | 0     | 0     | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     |
| **Desnecessários**           | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     | 0     | 0     |
| **Hardware não padronizado** | 0     | 0     | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     |
| **Alinhamento a negócios**   | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     | 0     | 0     |
| **Ambiguidade**              | 0     | 0     | 0     | 0     | 0     | 0     | 1     | 0     | 1     | 0     |
| **Realismo**                 | 0     | 0     | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     |
| **Testabilidade**            | 1     | 0     | 0     | 0     | 0     | 0     | 1     | 0     | 0     | 0     |

Legenda:
- 0 = Não aplicável
- 1 = Problema identificado

## 2. Principais Problemas

### CDU07 (Ler Código de Barras)
- **Prematuro**: Especifica uso de câmera sem definir requisitos técnicos
- **Combinado**: Mistura duas funcionalidades (salvar e comparar)
- **Hardware**: Assume dispositivo com câmera sem especificar
- **Ambiguidade**: "salvá-lo ou compará-lo" é aberto a interpretações
- **Testabilidade**: Falta critério claro para validação

### CDU05 (Marcar Produto no Carrinho)
- **Desnecessário**: Funcionalidade parece redundante com CDU03/CDU06
- **Negócios**: Não está claro como agrega valor ao objetivo principal

### CDU09 (Editar Produto Salvo)
- **Ambiguidade**: Não especifica limites de edição

## 3. Negociação de Requisitos

### Conflitos Identificados

1. **CDU02 x CDU09 x CDU10** (Conflito de dados):
   - Editar (CDU09) e Remover (CDU10) produtos salvos criam inconsistência potencial

2. **CDU03 x CDU05 x CDU06** (Sobreposição funcional):
   - Funcionalidades de lista de compras têm sobreposição significativa

3. **CDU01 x CDU07** (Sobreposição de comparação):
   - Ambos lidam com comparação de produtos

### Resolução de Conflitos

1. **Conflito CDU02/CDU09/CDU10**:
   - Técnica: Definição de regras de consistência
   - Solução: 
     - CDU09 não permitirá edição de código de barras
     - CDU10 exigirá confirmação em 2 etapas para exclusão

2. **Sobreposição CDU03/CDU05/CDU06**:
   - Técnica: Unificação de requisitos
   - Solução:
     - Fundir CDU05 em CDU03 como "marcar itens comprados"
     - Manter CDU06 como funcionalidade separada

3. **Sobreposição CDU01/CDU07**:
   - Técnica: Especialização de requisitos
   - Solução:
     - CDU01 fica responsável por comparação manual
     - CDU07 por comparação via código de barras

## 4. Recomendações

1. Refatorar CDU07 em dois requisitos distintos:
   - CDU07a: Escanear código de barras para cadastro
   - CDU07b: Escanear código para comparação imediata

2. Remover CDU05 e incorporar sua funcionalidade em CDU03

3. Adicionar requisitos não-funcionais sobre:
   - Compatibilidade com dispositivos móveis
   - Performance em leitura de códigos de barras
   - Armazenamento local de dados

4. Criar glossário técnico com termos:
   - "código de barras" (padrão EAN-13)
   - "volume/peso" (unidades de medida)
   - "lista de compras" (estrutura de dados)
