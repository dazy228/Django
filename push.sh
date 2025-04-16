#!/bin/bash

echo "Введите сообщение коммита:"
read commit_message

git add .
git commit -m "$commit_message"
git push origin main