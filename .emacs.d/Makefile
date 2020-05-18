clean:
	@rm -f init.elc emacs.el emacs.elc

compile: init.el emacs.org clean
	@emacs -q --batch -l 'lisp/compile.el'
