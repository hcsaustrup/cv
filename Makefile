.PRECIOUS: .pdf .md

MARKDOWNS := $(wildcard CV.*.md)
PDFS := $(patsubst %.md,%.pdf,$(MARKDOWNS))
IMAGES := $(filter-out $(wildcard .assets/*-scaled.jpeg), $(wildcard .assets/*.jpeg))
SCALED := $(patsubst %.jpeg,%-scaled.jpeg,$(IMAGES))
GENERATED := $(PDFS) $(SCALED)

all: $(PDFS)

%.pdf: %.md $(SCALED)
	pandoc --pdf-engine=lualatex --metadata-file=.pandoc/metadata.yaml $< -o $@

%-scaled.jpeg: %.jpeg
	convert $< -scale 300x300 $@

clean:
	rm -rf $(GENERATED)
