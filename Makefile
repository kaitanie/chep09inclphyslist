d = ah09aProceedings
d1 = chep09geant4
#d1 = jpcsSample

# extended report
#d = ah08hCodeReport
tex       = pdflatex
#tex       = latex
pdfviewer = /home/aatos/Desktop/system/tools/acroread/opt/Adobe/Reader8/bin/./acroread
#pdfviewer = gv
#pdfviewer = firefox
dviviewer = xdvi -allowshell -geometry 700x900+750+100 

all: 
	@echo :::document = $(d)
	@echo :::preparing latex ...
	@c; rm -f *.aux
ifdef AHSYSTEM
#	rm -f refs.bib ; cp ../refs.bib . ; # use always the mother file for the bibliography
endif
	@makeindex $(d).tex; $(tex) $(d); bibtex $(d); $(tex) $(d); $(tex) $(d); asy $(d); $(tex) $(d)
ifdef AHSYSTEM
	$(dviviewer) $(d).dvi &
	$(pdfviewer) $(d).pdf
endif

ca:
	rm -f *.pdf *.ps *.out $(d)_*.eps $(d).asy

paper:
	@echo :::CHEP09 TMVA paper = $(d1)
	@rm -f *.aux
	@latex $(d1) && latex $(d1) 
#	@$(tex) $(d1) && $(tex) $(d1) 
	@dvips -R0 $(d1).dvi -o $(d1).ps
	@ps2pdf $(d1).ps
ifdef USEVIEWER
	$(PDFVIEWER) $(d1).pdf
endif

files:
	ls -latGg code/$(GI)  >  code/bertiniFiles.txt
	ls -latGg code/$(GI)  >> code/bertiniFiles.txt

gpin:   # grep pi-N scattering
	rm -f code/pin.grep;g
	grep -nisr tetnew code/ > code/pin.grep;
	grep -nisr phfun code/ >> code/pin.grep;

pdf:
	@echo :: prepare ps and pdf from dvi
	@dvips -R0 $(d).dvi -o $(d).ps
	@ps2pdf $(d).ps
ifdef AHSYSTEM
	$(pdfviewer) $(d).pdf &
endif
s:
	@echo :::launching browser... 
	@konqueror -geometry 650x1600+950+0 $(d).dvi &
	@echo :::done.

CODE = G4NucleiModel.cc
codetex: #prepare file to be included to latex
	echo " \begin{verbatim} "  > code/$(CODE).tex; \
        cat  code/$(CODE)         >> code/$(CODE).tex; \
        echo " \end{verbatim}   " >> code/$(CODE).tex; \
	ls -alt code

FIX  = FIX080213
codefix: #prepare file to be included to latex
	echo " \begin{verbatim} "       > code/$(FIX)$(CODE).tex; \
        grep -nisr $(FIX) code/$(CODE) >> code/$(FIX)$(CODE).tex; \
        echo " \end{verbatim}   "      >> code/$(FIX)$(CODE).tex; \
	ls -alt code

#-----------------SLIDE
slides:
	$(tex) $(d).tex; $(tex) $(d).tex; $(pdfviewer) $(d).pdf &

SOURCEFILE = d
show:
	$(pdfviewer) $(SOURCEFILE).pdf &

html: $(SOURCEFILE).pdf
	pdftohtml $(SOURCEFILE).pdf

pdfs: $(SOURCEFILE).tex 
	$(PDFGENERATOR) $(SOURCEFILE)
	$(PDFGENERATOR) $(SOURCEFILE)

dvi: $(SOURCEFILE).tex filter
	$(DVIGENERATOR) $(SOURCEFILE)
	$(DVIGENERATOR) $(SOURCEFILE)
	$(DVIGENERATOR) $(FILTEREDFISRC)
	$(DVIGENERATOR) $(FILTEREDFISRC)

ps: dvi
	$(PSGENERATOR) $(SOURCEFILE).dvi -o $(SOURCEFILE).ps
	$(PSGENERATOR) $(FILTEREDFISRC).dvi -o $(FILTEREDFISRC).ps

filter: $(FISOURCEFILE).tex
	cat $(FISOURCEFILE).tex |sed "s/ä/\\\\\"a/g" | sed "s/Ä/\\\\\"A/g" | sed "s/ö/\\\\\"o/g" | sed "s/Ö/\\\\\"O/g" > $(FILTEREDFISRC).tex


#END SLIDE -----------------------

includes::
	@for dir in HEPGeometry HEPRandom; do \
	    (cd $$dir && $(MAKE) $@); \
	 done   

FIELD += 01 02 03 04
# Field
field:
	@$(ECHO) Making Field Tests...
	@for nn in $(FIELD); do \
	  (cd test7$$nn && $(MAKE)); \
	done;:

SUBDIRS = N01 N02 N03 N04 N05 N06 N07
clean:
	@for dir in $(SUBDIRS); do (cd $$dir; $(MAKE) clean); done

unique := $(shell echo $$$$)
libmap: liblist
	@$(ECHO) "Libmap stage. Searching for GNUmakefiles and sorting ..."
	@find . \
	  -name GNUmakefile -exec $(GREP) -l '^ *name *:=' {} \; \
	  | sort \
	  > /tmp/G4_all_lib_makefiles.$(unique);

ifneq (,$(findstring Linux-g++,$(G4SYSTEM)))
	@rm -f $(G4TMPDIR)/G4run/G4RunManagerKernel.*

else
	@cd $(G4INSTALL)/source/run; $(MAKE) G4FPE_DEBUG=1;
	@if [ ! -d $(G4LIBDIR) ] ; then mkdir $(G4LIBDIR) ;fi

name := G4hepgeometry

ifndef G4INSTALL
  G4INSTALL = ../../..
endif

glob global: banner kernel
ifdef G4LIB_USE_G3TOG4
	@for dir in $(SUBDIR4); do (cd $$dir && $(MAKE)); done;:
endif
	@$(MAKE) libmap
	@$(ECHO) "Libraries installation completed !"; done
endif

addPK:
	git remote add pekka git://github.com/kaitanie/chep09inclphyslist.git  

getPK:
	git fetch pekka
	git merge pekka/master

gitClonePK:
	git://github.com/kaitanie/chep09inclphyslist.git  

gitClone:
	git clone git@github.com:aatos/chep09inclphyslist.git  

#git diff
#git status
#git commit -a -m 'comment'  (add all changes)
#(modify)
#git diff
#git commit -a -m 'comment'  
#gitk 
#git push 

#git revert HEAD  (in case of bad commit this reverses it)