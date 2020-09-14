# wildcard only directories
dirs := $(filter-out root/,$(dir $(wildcard */.)))

.PHONY: all
all:
	@echo "installing packages..."
	stow --dotfiles $(dirs) --target=$(HOME)
	@echo "run make root to install root packages"

# packages that require previledges
root:
	@echo "installing root packages..."
	$(MAKE) -C root all

.PHONY: clean
clean:
	stow --delete --dotfiles $(dirs) --target=$(HOME)

