dirs := $(dir $(wildcard */.))

.PHONY: all
all:
	sudo stow --no-folding $(dirs) --target=/

.PHONY: clean
clean:
	sudo stow $(dirs) --delete --target=/

