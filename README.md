# package-tracker

Package collection tracker for my Arch Linux workstation.

## How to use

Running `make` produces two files: `missing.txt` and `untracked.txt`.

- `untracked.txt` contains packages not found in the lists under the src directory
- `missing.txt` contains packages not **explicitly** installed on the computer that exists in the lists under the src directory

You can then mass-install or mass-remove packages, the choice is yours.

Other make recipes:

- `install_missing`
- `mark_missing_as_explicit`
- `remove_untracked`
- `collect_untracked`
