dirs := $(dir $(wildcard */.))

.PHONY: all
all:
	sudo stow $(dirs) --target=/

.PHONY: clean
clean:
	sudo stow $(dirs) --delete --target=/

