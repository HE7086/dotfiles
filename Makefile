# wildcard only directories
exclude_dirs := root PKGBUILD Deprecated
pkgs := $(filter-out $(exclude_dirs),$(dir $(wildcard */.)))
pkgs := $(patsubst %/,%,$(pkgs))

.PHONY: all
all: $(pkgs)

.PHONY: $(pkgs)
$(pkgs): %:
	@echo "installing package $@"
	stow --no-folding $@ --target=$(HOME)

.PHONY: test
test:
	@echo $(pkgs)

.PHONY: clean
clean:
	stow --delete $(pkgs) --target=$(HOME)
