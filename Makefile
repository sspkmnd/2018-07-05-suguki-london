.PHONY: watch
watch:
	ls slides.md | entr make slides.html

.PHONY: slides
slides: slides.html

%.html: %.md
	pandoc --standalone -V transition=slide -V theme=white -V rollingLinks=true \
	       --mathjax -i -t revealjs $^ -o $@

.PHONY: ghpages
ghpages:
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
