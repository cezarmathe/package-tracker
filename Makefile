# package-tracker makefile

all:
	./scripts/run.sh
.PHONY: all

install_missing:
	yay -S --needed --asexplicit - < missing.txt
.PHONY: install_missing

mark_missing_as_explicit:
	yay -D --asexplicit - < missing.txt
.PHONY: mark_missing_as_explicit

remove_untracked:
	yay -Rns - < untracked.txt
.PHONY: remove_untracked

collect_untracked:
	mv untracked.txt src/others.txt
.PHONY: collect_untracked
