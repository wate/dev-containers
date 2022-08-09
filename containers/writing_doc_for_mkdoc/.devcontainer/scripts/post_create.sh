pip3 install --user -r .devcontainer/requirements.txt
if [ ! -e mkdocs.yml ]; then
  mkdocs new ./
fi