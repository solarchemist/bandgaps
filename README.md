[![DOI](https://zenodo.org/badge/125443865.svg)](https://zenodo.org/badge/latestdoi/125443865)

# Band edge positions and band gaps for some semiconductors

This R package contains an extensible dataset of band edge positions and band gaps of many 
commonly used semiconductor photocatalysts. The band edge positions are given vs the 
absolute vacuum scale (AVS) and also vs SHE with the aid of 
my [`refelectrodes` package](https://github.com/solarchemist/refelectrodes).


## Dataset 

The data for each semiconductor is collected in `./inst/extdata/semiconductors.R`, in a simple list format.

[The vignette `data`](https://github.com/chepec/bandgaps/blob/master/doc/data.pdf) presents the full 
dataset as a nicely typeset LaTeX table (produced using `xtable`). 


## Illustrations

You can easily create diagrams using the data in this package, for example, to represent the thermodynamic 
equilibrium positions of selected semiconductors as simple line-art (as commonly used in the field).

[The vignette `diagram`](https://github.com/chepec/bandgaps/blob/master/doc/diagram.pdf) show-cases how we 
can generate such diagrams with both base graphics and ggplot2. 
It also includes a publication-quality pure-TikZ-based version of the diagram. 
All diagrams make use of LaTeX (specifically by using the `siunitx` and `chemformula` packages to 
typeset units and chemical formulae).
