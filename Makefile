all:
	latex fp2009
	latex fp2009
	dvips -o fp2009.ps fp2009.dvi
	ps2pdf fp2009.ps

clean_all:
	rm -f *.out, *.pdf *.ps

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