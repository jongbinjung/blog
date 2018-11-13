all:
	./build.R

%.rmd: archetypes/rmarkdown.skeleton
	cat $< | sed -e "s/^date:/date: \"$(shell date +%FT%R:%S%:z)\"/" > rsrc/$@

diary:
	hugo new post/diary/`date +%Y`/`date +%m%d`.md --kind=diary

clean:
	rm -r ./content/post/rmd/*
	rm -r ./static/img/posts/R/
