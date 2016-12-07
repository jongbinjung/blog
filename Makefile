all:
	./build.R

%.rmd: archetypes/rmarkdown.skeleton
	cat $< | sed -e "s/^date:/date: \"$(shell date +%FT%R:%S%:z)\"/" > rsrc/$@

clean:
	rm -r ./static/img/posts/R/
