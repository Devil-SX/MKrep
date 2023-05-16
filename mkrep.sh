#!/bin/bash
your_token="<Your Token>"
github_name="<Your Github Username>"

SHELL_FOLDER=$(dirname $(readlink -f "${0}"))
# echo "Script path: $SHELL_FOLDER"

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $your_token"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/repos \
  -d '{"name":"'"$1"'","private":false}'

git init
git branch -m main
git remote add origin "git@github.com:${github_name}/${1}.git" -m main
cp -rf ${SHELL_FOLDER}/template/. ./
# 这里不能写成 /template/* 不能正确复制隐藏文件

git add .
git commit -m "First commit"
git push -u origin main

echo "Create repo sucessfully!"