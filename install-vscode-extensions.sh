cat vscode-extensions.txt | \
  grep -v -e '^#.*$' | \
  grep -v -e '^[[:space:]]*$' | \
  xargs -n 1 code --install-extension
