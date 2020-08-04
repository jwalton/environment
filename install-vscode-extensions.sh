if ! which code > /dev/null; then
  echo "**** VS Code not installed - skipping installation of extensions."
  echo "**** After installing VS Code, run ./install-vscode-extensions.sh"
else
  cat vscode-extensions.txt | \
    grep -v -e '^#.*$' | \
    grep -v -e '^[[:space:]]*$' | \
    xargs -n 1 code --install-extension
fi