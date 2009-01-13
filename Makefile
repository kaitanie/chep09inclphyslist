all:
	latex fp2009
	latex fp2009
	dvips -o fp2009.ps fp2009.dvi
	ps2pdf fp2009.ps

