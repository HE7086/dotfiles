# wildcard only directories
dirs := $(filter-out root $(dir $(wildcard */.)))
rootpkgs := $(dir $(wildcard root/*/.))

.PHONY: all
all:
	stow --dotfiles $(dirs) --target=$(HOME)

# packages that require previledges
root:
	sudo stow --dotfiles $(rootpkgs) --dir=root --target=/

.PHONY: clean
clean:
	stow --delete --dotfiles $(dirs) --target=$(HOME)

