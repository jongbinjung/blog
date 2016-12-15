Source code for generating and maintaining my [blog](http://blog.jongbin.com).
The static content of the blog is generated using `hugo`, and is hosted
separately [here](https://github.com/jongbinjung/jongbinjung.github.io):
https://github.com/jongbinjung/jongbinjung.github.io

# Basic usage

## Using `make`

The `Makefile` is primarily for managing non-markdown content (e.g., stuff
written with Rmarkdown). Use

```bash
make
```

to (re)generate all non-markdown content from sources.

```bash
make clean
```

will safely remove auto-generated markdown files.

### Starting a new Rmd post

```bash
make some/structure/filename.rmd
```

will create the `some/structure` directories under the `rsrc/` directory and
copy the `rmd` skeleton from `archetypes` with an up-to-date timestamp.

## Build R markdown files

The `build.R` script will search for all `rmd` files under `rsrc/`, compare
with `md` files with the same `path/filename` under `content/post/rmd`, and use
`knitr` to recompile the target markdown file if (1) it doesn't exist or (2)
if its timestamp is earlier than the `rmd` file.

This script should be linked as the custom build script when using Rstudio (see
`blog.Rproj` file)

## Testing locally

To have `hugo` serve a local instance of the blog (with drafts enabled), run
the `test.sh` script.

# Deploying the blog

The `deploy.sh` script is setup to

1. compile a latest production version of the blog in `blog.jongbin.com/`
1. push changes (including change logs from this repo) to the
[hosting repo on github](https://github.com/jongbinjung/jongbinjung.github.io)

# Directory structure

```bash
.
|-- archetypes        # template for content types
|-- blog.jongbin.com  # publishing directory
|-- content           # raw (.md) content
|-- data              # data file used in posts
|-- rsrc              # source files for R content (e.g., Rmd files)
|-- static            # static resources
|   |-- css
|   |-- fonts
|   `-- img
|-- themes
|   `-- base16        # base16 modified for Korean (as submodule)
|-- build.R           # build script for generating md from Rmd
|-- config.toml       # global configs
|-- deploy.sh         # script to deploy to blog.jongbin.com
|-- Makefile
|-- readme.md
`-- test.sh           # script to run hugo locally for testing
```
