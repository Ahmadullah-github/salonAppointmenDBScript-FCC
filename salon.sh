#!/bin/bash
psql="psql -X --username=freecodecamp --dbname=salon --tuples-only  -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can i help you?\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi 
  SERVICE_LISTS=$($psql "select * from services")
  echo -e "$SERVICE_LISTS" | while read SERVICE_ID BAR SERVICE_NAME 
  do
    echo -e "$SERVICE_ID) $SERVICE_NAME"
  done
  read SERVICE_ID_SELECTED 
  SERVICE_ID_CHECK=$($psql "select service_id from services where service_id='$SERVICE_ID_SELECTED'" )
  # echo "$SERVICE_ID_CHECK"

  if [[ -z $SERVICE_ID_CHECK ]] 
  then 
    MAIN_MENU "I could not find that service. What would you like today?"
  else 
    CUSTOMER_REGISTRATION $SERVICE_ID_SELECTED
  fi
}      


CUSTOMER_REGISTRATION(){
  SERVICE_ID_SELECTED=$1
  # echo "$SERVICE_ID_SELECTED"
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE 
  CHECK_CUSTOMER_PHONE=$($psql "select phone from customers where phone='$CUSTOMER_PHONE'")
  # echo "$CHECK_CUSTOMER_PHONE"
  if [[ -z $CHECK_CUSTOMER_PHONE ]]
  then 
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    CUSTOMER_INSERTION=$($psql "insert into customers (name, phone) values ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    APPOINTING_SERVICE $SERVICE_ID_SELECTED $CUSTOMER_PHONE
  else 
    APPOINTING_SERVICE $SERVICE_ID_SELECTED $CUSTOMER_PHONE
  fi 
}

APPOINTING_SERVICE(){
  SERVICE_ID_SELECTED=$1
  #echo "$SERVICE_ID_SELECTED"
  CUSTOMER_PHONE=$2
  #echo "$CUSTOMER_PHONE"
  CUSTOMER_NAME=$($psql "select name from customers where phone = '$CUSTOMER_PHONE'")
  CUSTOMER_ID=$($psql "select customer_id from customers where phone = '$CUSTOMER_PHONE'")
  SERVICE_SELECTED=$($psql "select name from services where service_id = '$SERVICE_ID_SELECTED'")
  echo -e "\nWhat time would you like your $SERVICE_SELECTED, $CUSTOMER_NAME?"
  read SERVICE_TIME

  SETTING_APPOINTMENT=$($psql "insert into appointments (customer_id,service_id,time) values ('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME') ")
  # echo "$SETTING_APPOINTMENT"

  SERVICE_SELECTED_CLEAN=$(echo $SERVICE_SELECTED | sed 's/^ *//g')
  CUSTOMER_NAME_CLEAN=$(echo $CUSTOMER_NAME | sed 's/^ *//g')
  echo -e "\nI have put you down for a $SERVICE_SELECTED_CLEAN at $SERVICE_TIME, $CUSTOMER_NAME_CLEAN."

}

MAIN_MENU