# Salon Appointment Scheduler - Bash + PostgreSQL

Este projeto faz parte do curso de **Relational Databases** da [freeCodeCamp](https://www.freecodecamp.org/). Ele consiste em um agendador de horários para um salão de beleza, utilizando **Bash script** e **PostgreSQL** como banco de dados.

> ⚠️ Este repositório foi criado exclusivamente para submissão e verificação do projeto final do curso no sistema da freeCodeCamp.

## Sobre o Projeto

O script principal (`salon.sh`) interage com o usuário via terminal para:
- Listar serviços disponíveis;
- Registrar clientes pelo número de telefone;
- Marcar compromissos com horário;
- Salvar as informações no banco de dados PostgreSQL.

## Estrutura

- `salon.sh`: Script principal do projeto.
- `salon.sql`: Dump do banco de dados (estrutura + dados iniciais).
- Banco de dados: Inclui tabelas `customers`, `services`, e `appointments`.

## Como executar

1. Dê permissão de execução ao script:

```bash
chmod +x salon.sh
