[![DOI](https://raw.githubusercontent.com/solarchemist/bandgaps/master/man/figures/badge-doi.svg)](https://doi.org/10.5281/zenodo.4099766)
[![Vignettes](https://raw.githubusercontent.com/solarchemist/bandgaps/master/man/figures/badge-vignette.svg)](https://github.com/solarchemist/bandgaps#read-the-vignettes)

# Band gaps and edges for some semiconductors

This R package contains a small, but easily extensible, dataset of band gaps and
band edge positions of most commonly used chalcogenide semiconductor photocatalysts.
The band edge positions are listed versus the absolute vacuum scale (AVS) and can
easily be converted to other reference electrode scales (such as SHE) with the aid
of the [`refelectrodes` package](https://github.com/solarchemist/refelectrodes).


## Install this package

To use this package, install it from this repo:

```
install.packages("remotes")
remotes::install_github("solarchemist/bandgaps")
```

If you encounter bugs or have questions
[please open an issue](https://github.com/solarchemist/bandgaps/issues).


## Read the vignettes

+ The [`data` vignette](https://raw.githubusercontent.com/solarchemist/bandgaps/master/doc/data.pdf)
  presents the complete dataset as a pretty LaTeX table.
+ The [`diagram` vignette](https://raw.githubusercontent.com/solarchemist/bandgaps/master/doc/diagram.pdf)
  demonstrates how to generate line-art diagrams representing the thermodynamic
  equilibrium positions of selected semiconductors (as commonly used in the field)
  with both R base graphics and ggplot2.
  This vignette also includes a publication-quality purely TikZ-based diagram.

## Improve the dataset

The data for each semiconductor is recorded in `./inst/extdata/semiconductors.R`
in a simple list format. To add new semiconductors, extend this file by adding
new `semiconductors <- rbind(semiconductors, semiconductor_row(...))` statements.
Then patch the line towards the end of the file that says `usethis::use_data(semiconductors)`
to `usethis::use_data(semiconductors, overwrite=TRUE)` and rerun the R file.


## Develop this package

Check out the source code from this repo:
```
git clone https://github.com/solarchemist/bandgaps.git
```

I suggest the following package rebuild procedure:

+ Run `devtools::check()` (in the console or via the RStudio **Build** pane).
  Should complete with one note about `undefined global functions or variables: label`
  but no warnings nor errors:
```
── R CMD check results ─────────────────────────── bandgaps 0.1.1.9000 ────
Duration: 2m 23.6s
0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
+ Run `devtools::build_vignettes()` ro recompile the vignettes (this rewrites the
  vignette output files in the `doc/` directory).
+ Manually remove the line `doc` from `.gitignore` (the vignette build step adds it).

Contributions are welcome, no matter whether code, bug reports or suggestions!


## Citing this package

To cite `bandgaps` in publications use:

Taha Ahmed (2023). The bandgaps package: band gaps and edges for some semiconductors.
DOI: [10.5281/zenodo.4099766](https://doi.org/10.5281/zenodo.4099766).

Or see the `CITATION.cff` ([citation file format](https://citation-file-format.github.io/))
file in this repo or in the GitHub sidebar.
Please note that the DOI above always resolves to the latest release of this package.
If you want to explicitly cite a particular version, please use the corresponding DOI
(listed on the [Zenodo page](https://doi.org/10.5281/zenodo.4099766)).
