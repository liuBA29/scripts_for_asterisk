#!/bin/bash

# Настройки (замените значения на актуальные)
FTPSRV="${FTP_SERVER}"
FTPUSER="${FTP_USER}"
FTPPWD="${FTP_PASSWORD}"

DIR="/ftpuser"
MONPATH="/var/spool/asterisk/monitor"

# Функция для выполнения FTP команд
ftpcommand() {
  lftp -u $FTPUSER,$FTPPWD -e "$1" $FTPSRV
}

# Создание базовых директорий на FTP-сервере
ftpcommand "mkdir -p asterisk/$DIR; quit;"

# Текущие даты
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")

# Проверка существования локальной директории для сегодняшней даты
if [ -d "$MONPATH/$YEAR/$MONTH/$DAY" ]; then
  # Создание директорий для текущего дня на FTP-сервере
  ftpcommand "mkdir -p asterisk/$DIR/$YEAR/$MONTH/$DAY; quit;"

  # Перенос файлов на FTP-сервер
  for FILE in "$MONPATH/$YEAR/$MONTH/$DAY"/*; do
    [ -e "$FILE" ] || continue  # Пропуск, если файлов нет
    ftpcommand "cd /asterisk/$DIR/$YEAR/$MONTH/$DAY/; put \"$FILE\"; quit;"
  done

  # Удаление файлов за сегодняшний день только если папка существует
  echo "Удаление файлов за $YEAR/$MONTH/$DAY..."
  rm -rf "$MONPATH/$YEAR/$MONTH/$DAY"

  # Удаление пустых директорий
  find "$MONPATH" -mindepth 1 -type d -empty -delete
else
  echo "Директория за $YEAR/$MONTH/$DAY не найдена. Удаление не требуется."
fi
