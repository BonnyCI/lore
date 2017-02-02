#!/bin/bash

sudo npm install -g markdownlint-cli

# Fix markdownlint's environmental janky-ness
sudo sed 's/\#\!\/usr\/bin\/env node/\#\!\/usr\/bin\/env nodejs/' /usr/local/bin/markdownlint

markdownlint -c .markdownlint.js .
