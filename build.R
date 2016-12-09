#!/usr/bin/env Rscript

library(tools)
library(knitr)
# Initial setup for extra fonts
# library(extrafont)
# font_import()

build <- function(input_file, output_file) {
  knitr::knit(
    input=input_file,
    output=output_file,
    quiet=TRUE,
    encoding='utf-8'
  )
}

opts_knit$set(
  unnamed.chunk.label='plots',
  base.dir='static/img/posts/R',
  base.url='/img/posts/R/'
  )

source <- './rsrc'
target <- './content/post/rmd'

r <- sapply(list.files(source, pattern=".[Rr]md", recursive=TRUE),
            function (rmd) {
  input_file <- file.path(source, rmd)
  output_file <- file.path(target, paste0(file_path_sans_ext(rmd), '.md'))

  if (!file.exists(output_file)) {
    target_dir <- dirname(output_file)
    if (!dir.exists(target_dir)) {
      cat(sprintf('Creating new directory: %s\n', target_dir))
      dir.create(target_dir)
    }
    cat(sprintf('Build %s -> %s\n', input_file, output_file))
    build(input_file, output_file)
    return(TRUE)
  }

  if (as.POSIXlt(file.mtime(input_file)) > as.POSIXlt(file.mtime(output_file))) {
    cat(sprintf('Rebuild %s -> %s\n', input_file, output_file))
    build(input_file, output_file)
    return(TRUE)
  }
  return(FALSE)
})

cat(sprintf('Updated total %d pages\n', sum(r)))
