dirs := $(dir $(wildcard */.))

.PHONY: all
all:
	sudo stow $(dirs) --dotfiles --target=/

.PHONY: clean
clean:
	sudo stow $(dirs) --delete --dotfiles --target=/

