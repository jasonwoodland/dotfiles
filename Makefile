install:
	for pkg in */; do stow --dotfiles $$pkg; done

update:
	for pkg in */; do stow --dotfiles --restow $$pkg; done
	:
uninstall:
	for pkg in */; do stow --dotfiles --delete $$pkg; done
