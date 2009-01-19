all:
	latex fp2009
	latex fp2009
	dvips -E -o fp2009.eps fp2009.dvi
	ps2pdf fp2009.eps

clean_all:
	rm -f *.out, *.pdf *.ps *.out

gitClone:
	git clone git@github.com:aatos/incl-physicsdays.git

gitClonePk:
	git clone git://github.com/kaitanie/incl-physicsdays.git

gitAddPk:
	git remote add pkIncl git://github.com/kaitanie/incl-physicsdays.git

gitFetchPk:
	git fetch pkIncl
	git merge pkIncl/master
m:
	make; gv fp2009.pdf