# wildcard only directories
exclude_dirs := root/ other/
dirs := $(filter-out $(exclude_dirs),$(dir $(wildcard */.)))

.PHONY: all
all:
	@echo "installing packages..."
	stow $(dirs) --target=$(HOME)
	@echo "run make root to install root packages"

# packages that require previledges
root:
	@echo "installing root packages..."
	$(MAKE) -C root all

.PHONY: clean
clean:
	stow --delete $(dirs) --target=$(HOME)

