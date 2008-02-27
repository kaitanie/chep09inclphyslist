all:
	latex poster
	latex poster
#	dvips -Ppdf -G0 -ta4 poster
#	dvips -Ppdf -G0 -ta1 poster
	dvips -Ppdf -o poster.ps poster.dvi
	ps2pdf -dMaxSubsetPct=100 -dCompatibilityLevel=1.4 -dSubsetFonts=true -dEmbedAllFonts=true -sPAPERSIZE=a4 poster.ps