#!/usr/bin/env sh

npm run build

cd dist

git init
git add -A
git commit -m 'new deploy'

git push -f https://github.com/hugoriveros18/ultimate-calculator.git master:gh-pages

cd ..