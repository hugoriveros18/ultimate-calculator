#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m 'First deploy'

git push -f git@github.com:hugoriveros18/ultimate-calculator.git main:gh-pages

cd -