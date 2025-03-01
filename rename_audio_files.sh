#!/bin/bash
# Проверка наличия sox
if ! command -v sox &> /dev/null; then
    echo "Утилита 'sox' не установлена. Пожалуйста, установите её."
    exit 1
fi
# Путь к директории с .wav файлами
directory="wwwav"
# Анализ всех файлов с расширением .wav в указанной директории
for file in "$directory"/*.wav; do
    if [[ -f $file ]]; then
        # Получаем продолжительность файла
        duration=$(sox "$file" -n stat 2>&1 | grep 'Length' | awk '{print $3}')

        # Преобразуем в часы:минуты:секунды
        hours=$(printf "%02d" $(echo "$duration/3600" | bc))
        minutes=$(printf "%02d" $(echo "($duration%3600)/60" | bc))
        seconds=$(printf "%02d" $(echo "$duration%60" | bc))

        # Создаем новое имя файла
        new_file_name="${file%.wav} (duration ${hours}-${minutes}-${seconds}).wav"

        # Переименовываем файл
        mv "$file" "$new_file_name"
        echo "Файл $file переименован в $new_file_name"
    fi
done
