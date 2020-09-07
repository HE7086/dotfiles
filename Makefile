# wildcard only directories
dirs := $(dir $(wildcard */.))

.PHONY: all
all:
	stow --dotfiles $(dirs) --target=$(HOME)
