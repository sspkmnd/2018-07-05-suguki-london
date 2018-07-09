.PHONY: watch
watch:
	ls slides.md | entr make slides.html

.PHONY: slides
slides: slides.html

%.html: %.md template.revealjs
	pandoc --standalone --template=template.revealjs \
	       -V transition=slide -V theme=white -V rollingLinks=true \
	       -i -t revealjs $< -o $@

.PHONY: ghpages
ghpages: slides
	rm -rf docs
	mkdir -p docs
	rsync -rhvW --no-compress --progress --prune-empty-dirs \
	      --include=*/ \
	      --include=/js/** \
	      --include=/css/** \
	      --include=/lib/** \
	      --include=/plugin/** \
	      --exclude=* \
	      reveal.js/ docs/reveal.js
	cp -r assets docs
	cp slides.html docs/index.html
