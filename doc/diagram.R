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
             "\\sisetup{separate-uncertainty,detect-family,range-phrase=\\ensuremath{\\text{ to }}}\n",
             "\\DeclareSIUnit{\\counts}{cts}\n",
             "\\DeclareSIUnit{\\cps}{cps}\n",
             "\\DeclareSIUnit{\\molar}{\\mole\\per\\cubic\\deci\\metre}\n",
             "\\DeclareSIUnit{\\Molar}{\\textsc{m}}\n",
             "\\DeclareSIUnit{\\vsAgCl}{vs~\\ch{Ag}/\\ch{AgCl}}",
             "\\DeclareSIUnit{\\vsNHE}{vs~NHE}",
             "\\DeclareSIUnit{\\vsSHE}{vs~SHE}",
             "\\DeclareSIUnit{\\vsSCE}{vs~SCE}",
             "\\DeclareSIUnit{\\voltAgCl}{\\volt\\vsAgCl}",
             "\\DeclareSIUnit{\\voltNHE}{\\volt\\vsNHE}",
             "\\DeclareSIUnit{\\voltSHE}{\\volt\\vsSHE}",
             "\\DeclareSIUnit{\\voltSCE}{\\volt\\vsSCE}"),
   digits   = 7,
   width    = 84,
   continue = "  ",
   prompt   = "> ",
   stringsAsFactors = FALSE)
# here::i_am("vignettes/diagram.Rnw")

## ----'load-R-packages', echo=F, results='hide', message=FALSE---------------------
library(bandgaps)
# packages listed below should also be listed in DESCRIPTION
library(common)
# library(here)
# library(git2r)
#    repo <- repository(here())
library(graphics)
library(ggplot2)
# library(ggrepel) # am I using it?
library(dplyr)
library(tidyr)
library(xtable)
library(knitr)
opts_knit$set(self.contained = FALSE,
              child.path = '')
opts_chunk$set(dev = 'tikz',
               # external = TRUE only takes effect when tikz is the ONLY dev option
               external = TRUE,
               cache = FALSE,
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

## ----ref.label='bandgaps-plot-figure', echo=TRUE, eval=FALSE----------------------
#  plot_bandgaps(bandgaps::semiconductors %>% filter(Nernstian == TRUE))

## ----'bandgaps-plot-figure', fig.width=6, fig.height=3.71, out.width='6in'--------
plot_bandgaps(bandgaps::semiconductors %>% filter(Nernstian == TRUE))

## ----'bandgaps-ggplot-figure', fig.width=6, fig.height=3.71, out.width='6in'------
ggplot_materials <-
   bandgaps::semiconductors %>%
   # for recalculation of pH, only display Nernstian semiconductors
   filter(class == "oxide")
ggplot_materials <-
   ggplot_materials %>%
   # add column with x variable
   # NOTE: do this as the last step to avoid weird visual gaps
   # 0.4 is the x-value of the first line, stepsize 1.0
   mutate(x = seq(0.4, dim(ggplot_materials)[1], by = 1.0))
ggplot(data = ggplot_materials) +
   # water redox lines
   geom_hline(yintercept = 0.00, colour = "red", linetype = "dashed", size = 0.3) +
   geom_hline(yintercept = 1.23, colour = "blue", linetype = "dashed", size = 0.3) +
   # band gaps visualised as vertical lines
   geom_linerange(aes(x = x, ymin = CB, ymax = VB),
                  size = 0.8) +
   # label each compound
   geom_text(aes(x = x,
                 label = paste0("\\ch{", formula, "}"),
                 # can we put the label at VB if CB > than some value?
                 # also add a constant space between CB/VB and label
                 y = ifelse(CB > -0.5, CB - 0.05, VB + 0.05),
                 # left-adjust labels at CB, and right-adjust labels at VB
                 hjust = ifelse(CB > -0.5, 0, 1)),
             size = 3,
             vjust = 0.5,
             angle = 80) +
   # flip primary y-axis and create secondary AVS axis
   scale_y_continuous(
      name = "E(SHE)/V",
      # make sure each unit step is marked
      breaks = seq(-4, 6),
      # expand() parameters are
      # a multiplicative and an absolute expansion
      # we add some space to make sure the labels of the largest Eg fits
      expand = c(0, 0.65),
      trans = "reverse",
      sec.axis =
         # note the initial minus sign
         # which makes the AVS scale go positive up
         sec_axis(~ -. + refelectrodes::as.SHE(0, scale = "AVS"),
                  name = "E(AVS)/V")) +
   # a more suitable theme
   theme_classic() +
   # completely remove the x-axis
   theme(axis.text.x = element_blank(),
         axis.title.x = element_blank(),
         axis.line.x = element_blank(),
         axis.ticks.x = element_blank())

## ----ref.label='bandgaps-ggplot-figure', echo=TRUE, eval=FALSE--------------------
#  ggplot_materials <-
#     bandgaps::semiconductors %>%
#     # for recalculation of pH, only display Nernstian semiconductors
#     filter(class == "oxide")
#  ggplot_materials <-
#     ggplot_materials %>%
#     # add column with x variable
#     # NOTE: do this as the last step to avoid weird visual gaps
#     # 0.4 is the x-value of the first line, stepsize 1.0
#     mutate(x = seq(0.4, dim(ggplot_materials)[1], by = 1.0))
#  ggplot(data = ggplot_materials) +
#     # water redox lines
#     geom_hline(yintercept = 0.00, colour = "red", linetype = "dashed", size = 0.3) +
#     geom_hline(yintercept = 1.23, colour = "blue", linetype = "dashed", size = 0.3) +
#     # band gaps visualised as vertical lines
#     geom_linerange(aes(x = x, ymin = CB, ymax = VB),
#                    size = 0.8) +
#     # label each compound
#     geom_text(aes(x = x,
#                   label = paste0("\\ch{", formula, "}"),
#                   # can we put the label at VB if CB > than some value?
#                   # also add a constant space between CB/VB and label
#                   y = ifelse(CB > -0.5, CB - 0.05, VB + 0.05),
#                   # left-adjust labels at CB, and right-adjust labels at VB
#                   hjust = ifelse(CB > -0.5, 0, 1)),
#               size = 3,
#               vjust = 0.5,
#               angle = 80) +
#     # flip primary y-axis and create secondary AVS axis
#     scale_y_continuous(
#        name = "E(SHE)/V",
#        # make sure each unit step is marked
#        breaks = seq(-4, 6),
#        # expand() parameters are
#        # a multiplicative and an absolute expansion
#        # we add some space to make sure the labels of the largest Eg fits
#        expand = c(0, 0.65),
#        trans = "reverse",
#        sec.axis =
#           # note the initial minus sign
#           # which makes the AVS scale go positive up
#           sec_axis(~ -. + refelectrodes::as.SHE(0, scale = "AVS"),
#                    name = "E(AVS)/V")) +
#     # a more suitable theme
#     theme_classic() +
#     # completely remove the x-axis
#     theme(axis.text.x = element_blank(),
#           axis.title.x = element_blank(),
#           axis.line.x = element_blank(),
#           axis.ticks.x = element_blank())

## ----'bandgaps-tikz', results='asis'----------------------------------------------
# this chunk is bit of a hack to tie together the TikZ code with the bandgaps dataset
tikz_materials <-
   bandgaps::semiconductors %>%
   # exclude a few to make the TikZ plot fit (the TikZ plot dimensions are not set dynamically, that's something to do)
   filter(!formula %in% c("CdSe", "MoS2", "PbS")) %>%
   select(CB, VB, Eg, formula, polymorph) %>%
   mutate(CB = paste0("\\drawbg{", prettyNum(CB))) %>%
   # fnsymb column is empty since we only show oxides
   # so we will hack together an empty column in the right place
   mutate(Eg = paste(Eg, "\\phantom{1}")) %>%
   separate(Eg, sep = " ", c("Eg", "fnsymb")) %>%
   mutate(polymorph = paste0(polymorph, "}"))
tikz_materials %>%
   write.table(row.names = F,
               col.names = F,
               sep = "}  {",
               quote = F)

## ----'gitR-info', echo=FALSE, results='markup', cache=FALSE-----------------------
# status(repo)

## ----'R-session-info', echo=FALSE, results='asis', cache=FALSE--------------------
toLatex(sessionInfo(), locale=F)

## ----'pdflatex-version', echo=FALSE, results='asis'-------------------------------
latex.version.text <- system(command = "pdflatex -version", intern = TRUE)
# quick fixes: replace "\o" with "o", and remove all empty rows in latex.version.text
cat(paste0("\\noindent\n", paste(sub("\\\\o", "o", latex.version.text[which(latex.version.text != "")]), collapse = "\\\\\n")))

