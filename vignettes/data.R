## ----'R-setup', echo=F, results='hide', cache=FALSE-------------------------------
options(tikzDefaultEngine = "pdftex",
        "tikzLatexPackages" =
           c("\\usepackage{tikz}\n",
             "\\usepackage[active,tightpage,psfixbb]{preview}\n",
             "\\PreviewEnvironment{pgfpicture}\n",
             "\\setlength\\PreviewBorder{0pt}\n",
             "\\usepackage{chemformula}\n",
             "\\setchemformula{charge-style=math}\n",
             "\\usepackage{siunitx}\n",
             "\\sisetup{load-configurations=abbreviations,separate-uncertainty,detect-family,range-phrase=\\ensuremath{\\text{ to }}}\n",
             "\\DeclareSIUnit{\\counts}{cts}\n",
             "\\DeclareSIUnit{\\cps}{cps}\n",
             "\\DeclareSIUnit{\\molar}{\\mole\\per\\cubic\\deci\\metre}\n",
             "\\DeclareSIUnit{\\Molar}{\\textsc{m}}\n",
             "\\DeclareSIUnit{\\voltAgCl}{\\volt~vs.\\ \\ce{Ag}/\\ce{AgCl}}\n",
             "\\DeclareSIUnit{\\voltNHE}{\\volt~vs.\\ NHE}\n",
             "\\DeclareSIUnit{\\voltSHE}{\\volt~vs.\\ SHE}\n",
             "\\DeclareSIUnit{\\voltSCE}{\\volt~vs.\\ SCE}\n",
             "\\DeclareSIUnit{\\voltLi}{\\volt~vs.\\ \\ch{Li}/\\ch{Li+}}\n",
             "\\DeclareSIUnit{\\rpm}{rpm}\n"),
   digits   = 7,
   width    = 84,
   continue = "  ",
   prompt   = "> ",
   stringsAsFactors = FALSE)

## ----'load-R-packages', echo=F, results='hide', message=FALSE---------------------
# packages here should also be listed in DESCRIPTION
library(common)
# library(bandgaps)
library(git2r)
   repo <- repository("/media/bay/taha/chepec/chetex/common/R/bandgaps")
library(ggplot2)
library(magrittr)
library(dplyr)
library(xtable)
library(knitr)
opts_knit$set(self.contained = FALSE,
              child.path = '')
opts_chunk$set(dev = 'tikz',
               # external = TRUE only takes effect when tikz is the ONLY dev option
               external = TRUE,
               cache = TRUE,
               fig.width = 3.40, # 2.60,
               # corresponding height based on golden ratio (1.618034):
               # W 3.54 ==> H 2.19 >> works better >> W 2.60, H 1.61
               # W 5.51 ==> H 3.41
               # W 7.48 ==> H 4.62 >> works better >> W 5.40, H 3.34
               fig.height = 2.10, # 1.61,
               out.width = '3.40in', # '2.60in',
               fig.align = 'center',
               # size affects all knitr output. We use it primarily
               # to match knitr font size to figure captions
               size = 'footnotesize',
               echo = FALSE,
               eval = TRUE,
               results = 'hide',
               message = FALSE,
               tidy = FALSE)

## ----'gitR-info', echo=FALSE, results='markup', cache=FALSE-----------------------
status(repo)

## ----'R-session-info', echo=FALSE, results='asis', cache=FALSE--------------------
toLatex(sessionInfo(), locale=F)

## ----'pdflatex-version', echo=FALSE, results='asis'-------------------------------
latex.version.text <- system(command = "pdflatex -version", intern = TRUE)
# quick fixes: replace "\o" with "o", and remove all empty rows in latex.version.text
cat(paste0("\\noindent\n", paste(sub("\\\\o", "o", latex.version.text[which(latex.version.text != "")]), collapse = "\\\\\n")))

