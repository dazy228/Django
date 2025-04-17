#!/bin/bash

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

separator() {
    echo -e "${BLUE}----------------------------------------${NC}"
}

# Получаем текущую ветку
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Проверка: не в main
if [ "$current_branch" = "main" ]; then
    echo -e "${RED}🚫 Нельзя работать напрямую в main!${NC}"
    exit 1
fi

separator
echo -e "${YELLOW}📌 Текущая ветка: $current_branch${NC}"

# Коммит
echo -e "${YELLOW}💬 Введите сообщение коммита:${NC}"
read commit_message
git add .
git commit -m "$commit_message"

# Пуш
separator
echo -e "${GREEN}⬆️ Пушим ветку $current_branch...${NC}"
git push origin "$current_branch"

# Merge в main
separator
echo -e "${GREEN}🔀 Сливаем $current_branch → main локально...${NC}"
git checkout main
git merge "$current_branch"

# Удаление ветки
separator
echo -e "${RED}🧹 Удаляем ветку $current_branch...${NC}"
git branch -d "$current_branch"

# Новая ветка
separator
echo -e "${YELLOW}🆕 Введите имя новой ветки:${NC}"
read new_branch
git checkout -b "$new_branch"

separator
echo -e "${GREEN}✅ Готово! Ты теперь в ветке: $new_branch${NC}"
separator
