#!/bin/bash

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # Сброс цвета

separator() {
    echo -e "${BLUE}----------------------------------------${NC}"
}

# 1. Получаем имя текущей ветки
current_branch=$(git rev-parse --abbrev-ref HEAD)
separator
echo -e "${YELLOW}📌 Текущая ветка:${NC} $current_branch"
separator

# 2. Pull последней версии из удалённой ветки
echo -e "${BLUE}🔄 Обновляем локальную ветку $current_branch...${NC}"
git pull origin "$current_branch"

# 3. Добавляем и коммитим изменения
echo -e "${YELLOW}💬 Введите сообщение коммита:${NC}"
read commit_message
git add .
git commit -m "$commit_message"

# 4. Пушим текущую ветку
separator
echo -e "${GREEN}⬆️ Пушим изменения в ветку $current_branch...${NC}"
git push origin "$current_branch"

# 5. Если текущая ветка не main — продолжаем слияние
if [ "$current_branch" != "main" ]; then
    separator
    echo -e "${BLUE}🔁 Переключаемся на main...${NC}"
    git checkout main

    echo -e "${BLUE}📥 Подтягиваем последние изменения из origin/main...${NC}"
    git pull origin main

    separator
    echo -e "${GREEN}🔀 Сливаем $current_branch → main...${NC}"
    git merge "$current_branch"

    echo -e "${GREEN}⬆️ Пушим обновлённый main...${NC}"
    git push origin main

    separator
    echo -e "${RED}🧹 Удаляем ветку $current_branch (локально и в origin)...${NC}"
    git branch -d "$current_branch"
    git push origin --delete "$current_branch"
else
    echo -e "${RED}⚠️ Ты находишься на ветке main — пропускаем merge и удаление.${NC}"
fi

# 6. Создаём новую ветку
separator
echo -e "${YELLOW}🆕 Введите имя новой ветки:${NC}"
read new_branch
git checkout -b "$new_branch"
separator
echo -e "${GREEN}✅ Переключились в ветку: $new_branch${NC}"
separator
