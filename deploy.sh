#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run docs:build

# navigate into the build output directory
cd docs/.vuepress/dist

git init
git add -A
git commit -m 'deploy'

# deploying to https://activeadmin-plugins.github.io/capybara_active_admin
git push -f git@github.com:activeadmin-plugins/capybara_active_admin.git master:gh-pages

cd -
