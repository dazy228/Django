#!/bin/bash

# 1. Получаем имя текущей ветки
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Текущая ветка: $current_branch"

# 2. Pull последней версии из удалённой ветки
echo "Обновляем локальную ветку..."
git pull origin "$current_branch"

# 3. Добавляем и коммитим изменения
echo "Введите сообщение коммита:"
read commit_message
git add .
git commit -m "$commit_message"

# 4. Пушим текущую ветку
echo "Отправляем изменения в ветку $current_branch"
git push origin "$current_branch"

# 5. Переключаемся на main
echo "Переключаемся на main"
git checkout main

# 6. Обновляем main
git pull origin main

# 7. Сливаем текущую рабочую ветку в main
echo "Сливаем $current_branch в main"
git merge "$current_branch"

# 8. Пушим main
git push origin main

# 9. Удаляем локальную и удалённую ветку
echo "Удаляем ветку $current_branch"
git branch -d "$current_branch"
git push origin --delete "$current_branch"

# 10. Создаём новую ветку
echo "Введите имя новой ветки:"
read new_branch
git checkout -b "$new_branch"
echo "✅ Переключились в ветку: $new_branch"
