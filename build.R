#!/usr/bin/env Rscript

library(tools)
library(knitr)
opts_knit$set(
  unnamed.chunk.label='plots',
  base.dir='static/img/posts/R',
  base.url='/img/posts/R/'
  )
source <- './rsrc'
target <- './content/post/rmd'
r <- sapply(list.files(source, pattern=".[Rr]md"), function (rmd) {
  input_file <- file.path(source, rmd)
  output_file <- file.path(target, paste0(file_path_sans_ext(rmd), '.md'))
  if (!file.exists(output_file) || as.POSIXlt(file.mtime(input_file)) > as.POSIXlt(file.mtime(output_file))) {
    cat(sprintf('Rebuild %s -> %s\n', input_file, output_file))
    knitr::knit(
      input=input_file,
      output=output_file,
      quiet=TRUE,
      encoding='utf-8'
    )
    return(TRUE)
  }
  return(FALSE)
})

cat(sprintf('Updated total %d pages\n', sum(r)))
