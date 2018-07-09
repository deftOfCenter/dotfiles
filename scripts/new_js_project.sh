#!/bin/bash
# ubuntu.sh

#
#
yarn add eslint-config-airbnb@latest eslint eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react prettier eslint-plugin-prettier eslint-config-prettier --dev
echo "Popular Guide: AirBnB, React: as needed, JSON"
$(npm bin)/eslint --init
printf 'add\n"lint": "eslint .",\n"lintfix": "eslint . --fix"\nto package.json scripts'
printf "\nbuild/*" >> .eslintignore
cat << EOF > eslintrc.json
{
  "extends": [
    "airbnb",
    "prettier/react"
  ],
  "plugins": [
    "prettier"
  ],
  "env": {
    "browser": true,
    "jasmine": true
  },
  "rules": {
    "react/jsx-filename-extension": [1, {"extensions": [".js"]}],
    "prettier/prettier": ["error", { "singleQuote": true }]
  }
}
EOF

cat << EOF
for react setup, here is the .eslintrc.json
{
  "extends": [
    "airbnb",
    "prettier/react"
  ],
  "plugins": [
    "prettier"
  ],
  "env": {
    "browser": true,
    "jasmine": true
  },
  "rules": {
    "react/jsx-filename-extension": [1, {"extensions": [".js"]}],
    "prettier/prettier": ["error", { "singleQuote": true }]
  }
}
if not react, then remove the react parts

add
"lint": "eslint .",
"lintfix": "eslint . --fix"
to package.json scripts
for more info, https://georgespake.com/blog/eslint/
EOF
