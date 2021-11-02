install:
	for pkg in */; do stow --target $(HOME) --dotfiles $$pkg; done

update:
	for pkg in */; do stow --target $(HOME) --dotfiles --restow $$pkg; done

uninstall:
	for pkg in */; do stow --target $(HOME) --dotfiles --delete $$pkg; done
