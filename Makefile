ssh-gen:
	ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f gh-pages -N ""

.PHONY: ssh-gen