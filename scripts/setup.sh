#!/usr/bin/env bash

set -o errexit -o errtrace

header() {
    echo
    echo "------ $*"
}

header "Installing brew dependencies"

brew bundle

header "Running Pre-commit Install"

pre-commit install

# header "Installing action-docs"

# npm install -g action-docs

header "DIRENV Setup"

# Check if .envrc already exists
if [[ -f .envrc ]]; then
    echo ".envrc already exists, skipping copy."
else
    cp .envrc_sample .envrc
    direnv allow
    echo "You will want to fill out the .envrc for secrets to work with actions"
fi

echo
echo "If you haven't setup direnv before, you need to add one of these to your RC file:"
echo "For ZSH (.zshrc): eval \"$(direnv hook zsh)\""
echo "For BASH (.bashrc): eval \"$(direnv hook bash)\""

echo
echo "After adding the line, you should either restart your shell or source the file you edited."
echo "source ~/.zshrc OR source ~/.bashrc"
echo
echo "After that, when entering or leaving (using 'cd') the root directory, you should see"
echo "a message from direnv about loading or unloading."

header "Done."
