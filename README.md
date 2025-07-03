# dbt_exercise

## Descrição
Projeto de modelagem de dados utilizando dbt (Data Build Tool) com o dataset Northwind, focado em boas práticas de engenharia de dados, documentação e testes automatizados.

## Estrutura do Projeto
- **models/staging/**: Modelos de staging (extração e padronização dos dados brutos)
- **models/intermediate/**: Modelos intermediários (transformações, joins e enriquecimento)
- **models/marts/**: Modelos finais de mart (dimensões e fatos prontos para análise)
- **seeds/**: Arquivos CSV de dados de apoio
- **macros/**: Macros customizadas para uso no dbt

## Principais Modelos
- **dim_products**: Dimensão de produtos
- **dim_customers**: Dimensão de clientes
- **dim_employees**: Dimensão de funcionários
- **dim_ship**: Dimensão de transportadoras/endereços de entrega
- **fact_orders**: Fato de pedidos detalhado por produto

## Como executar
1. Instale as dependências do dbt e do projeto:
   ```bash
   dbt deps
   ```
2. Execute os modelos:
   ```bash
   dbt run
   ```
3. Execute os testes:
   ```bash
   dbt test
   ```

## Testes e Qualidade
O projeto utiliza testes de unicidade, não nulo e valores aceitos para garantir a qualidade dos dados.

## Autor
Damodara Barbosa