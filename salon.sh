#!/bin/bash

# Variável para facilitar execução de comandos SQL
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

# Função principal
MAIN_MENU() {
  echo -e "\n~~~~~ MY SALON ~~~~~\n"
  echo -e "Welcome to My Salon, how can I help you?\n"

  # Mostra a lista de serviços
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  # Lê a escolha do serviço
  read SERVICE_ID_SELECTED

  # Verifica se a escolha é válida
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  SERVICE_NAME=$(echo $SERVICE_NAME | sed 's/^ *//')

  if [[ -z $SERVICE_NAME ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    MAIN_MENU
  else
    # Pede o número de telefone
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    # Verifica se o cliente já existe
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed 's/^ *//')

    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi

    # Busca o ID do cliente
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    # Pede o horário
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    # Insere o agendamento
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    # Mensagem final
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

# Executa o menu
MAIN_MENU
