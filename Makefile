# Define directories
JOBNAME = 2025_Coldigiocco
QUARTO_DIR = Quarto_files
HTML_DIR = Html
PNG_DIR = Png
PDF_DIR = Pdf_output
XP_DIR = Xp_files
EEPIC_DIR = Eepic

MISC_SPECTRA =  R/EPi_spectrum_plot.pdf R/E_spectrum_plot.pdf R/cwt_E.png 
MISC = R/ZB20_eccentricity.png R/ZB23_01_eccentricity.png R/I_spectrum.pdf $(MISC_SPECTRA)

REPO_URL := $(shell git config --get remote.github.url)
COMMIT_HASH := $(shell git rev-parse --short HEAD)

# Automatically find Quarto files and define output paths
QMD = $(wildcard $(QUARTO_DIR)/*.qmd)
HTML = $(patsubst $(QUARTO_DIR)/%.qmd, $(HTML_DIR)/%.html, $(QMD))
PNG = $(patsubst $(HTML_DIR)/%.html, $(PNG_DIR)/%.png, $(HTML))
EEPIC = $(patsubst $(XP_DIR)/%.xp, $(EEPIC_DIR)/%.eepic, $(XP))
Presentation = $(PDF_DIR)/$(JOBNAME)_presentation.pdf
Handouts     = $(PDF_DIR)/$(JOBNAME)_handouts.pdf

# Rule to generate PDF from LaTeX and PNGs

presentation: $(JOBNAME).tex $(PNG) $(EEPIC) $(MISC) | $(PDF_DIR)
	pdflatex -jobname $(PDF_DIR)/2025_Coldigiocco_presentation "\PassOptionsToClass{beamer}{beamer}\input{2025_Coldigiocco.tex}"


# Create output directories before building files
$(HTML_DIR) $(PNG_DIR) $(PDF_DIR):
	mkdir -p $@



# Rules to generate HTML from Quarto files
$(HTML_DIR)/%.html: $(QUARTO_DIR)/%.qmd | $(HTML_DIR)
	quarto render $< --to html --self-contained --output-dir  $(PWD)/$(HTML_DIR) 

# Rules to generate PNG snippets from HTML files
$(PNG_DIR)/%.png: $(HTML_DIR)/%.html | $(PNG_DIR)
	wkhtmltoimage --enable-local-file-access --width 400 --height 300 file://$(PWD)/$< $@

# Rule to generate Eepic from XP files
$(EEPIC_DIR)/%.eepic: $(XP_DIR)/%.xp | $(EEPIC_DIR)
	cd $(XP_DIR) && epix $(notdir $<) && mv $(patsubst %.xp, %.eepic, $(notdir $<)) ../$(EEPIC_DIR)/ && cd ..


# Final presentation target

# Rule to generate LaTeX from Markdown
$(JOBNAME).tex: $(JOBNAME).mkd header.tex
	pandoc -s --template=templates/presentation.tex \
	         -H header.tex \
					 -t beamer \
		       -V url=$(REPO_URL) \
	         -V commit=$(COMMIT_HASH) \
					 2025_Coldigiocco.mkd -o 2025_Coldigiocco.tex

handouts: $(JOBNAME).tex $(PNG) $(EEPIC) | $(PDF_DIR)
	pdflatex -jobname $(PDF_DIR)/2025_Coldigiocco_presentation "\PassOptionsToClass{handout}{beamer}\input{${JOBNAME).tex}"

bibtex:
	@if [ -e $(JOBNAME)_handouts.aux ]; then \
	  echo "Running bibtex on $(JOBNAME)_handouts..."; \
	  bibtex $(JOBNAME)_handouts; \
	fi
	@if [ -e $(JOBNAME)_presentation.aux ]; then \
	  echo "Running bibtex on $(JOBNAME)_presentation..."; \
	  bibtex $(JOBNAME)_presentation; \
	fi


R/ZB20_eccentricity.png: R/zeebe_spectrum.R
	cd R  && Rscript zeebe_spectrum.R && cd .. 


R/ZB23_01_eccentricity.png: R/zeebe_big_spectrum.R
	cd R  && Rscript zeebe_big_spectrum.R && cd .. 

R/I_spectrum.pdf: R/I_spectrum.R
	cd R  && Rscript I_spectrum.R && cd .. 

$(MISC_SPECTRA): R/spectra.R
	cd R && Rscript spectra.R && cd .. 



clean:
	rm $(JOBNAME).vrb
	rm $(JOBNAME).snm
	rm $(JOBNAME).nav
	rm $(JOBNAME).out
	rm $(JOBNAME).log
	rm $(JOBNAME).bbl


	
