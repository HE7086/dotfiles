# wildcard only directories
dirs := $(dir $(wildcard */.))

.PHONY: all
all:
	stow --dotfiles $(dirs) --target=$(HOME)

.PHONY:
clean:
	stow --delete --dotfiles $(dirs) --target=$(HOME)

