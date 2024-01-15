# wildcard only directories
exclude_dirs := root/ PKGBUILD/ Deprecated/ Submodules/
pkgs := $(filter-out $(exclude_dirs),$(dir $(wildcard */.)))
pkgs := $(patsubst %/,%,$(pkgs))

.PHONY: all
all: $(pkgs)

.PHONY: $(pkgs)
$(pkgs): %:
	@echo "installing package $@"
	@stow -v --no-folding $@ --target=$(HOME)

.PHONY: Submodules
Submodules:
	@mkdir -p ~/.config/Submodules
	@if [ -w . ]; then \
		for mod in $(abspath $(wildcard Submodules/*)); do \
			ln -sf $$mod ~/.config/Submodules; \
		done \
	else \
		for mod in $(abspath $(wildcard Submodules/*)); do \
			cp --reflink=auto -ru $$mod ~/.config/Submodules; \
		done \
		for mod in $(abspath $(wildcard ~/.config/Submodules/*)); do \
			chmod 755 $$mod; \
		done
	fi

.PHONY: test
test:
	@if [ -w . ]; then \
		for mod in $(abspath $(wildcard Submodules/*)); do \
			echo $$mod; \
		done \
	fi

.PHONY: clean
clean:
	@stow --delete $(pkgs) --target=$(HOME)
