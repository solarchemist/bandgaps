## ----'R-setup', echo=F, results='hide', cache=FALSE-------------------------------
options(
   tikzDefaultEngine = "pdftex",
   "tikzLatexPackages" = c(
      "\\usepackage{tikz}\n",
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
# Was getting this confusing error during devtools:check() if library(here) was used (same for the other vignette).
# Only fixed by not using library(here) anymore (adding here::i_am() had no effect):
#    > checking re-building of vignette outputs ... WARNING
#   Error(s) in re-building vignettes:
#     ...
#   --- re-building ‘data.Rnw’ using knitr
#   here() starts at /media/bay/taha/chepec/chetex/common/R/bandgaps.Rcheck/vign_test/bandgaps
#   Quitting from lines 167-199 (data.Rnw)
#   Error: processing vignette 'data.Rnw' failed with diagnostics:
#   The 'path' is not in a git repository
#   --- failed re-building ‘data.Rnw’
# here::i_am("vignettes/data.Rnw")

## ----'load-R-packages', echo=F, results='hide', message=FALSE---------------------
library(bandgaps)
library(refelectrodes)
# packages listed below should also be listed in DESCRIPTION
# library(here)
library(common)
# library(git2r)
#    repo <- repository(here())
library(dplyr)
library(xtable)
library(knitr)
opts_knit$set(
   self.contained = FALSE,
   child.path = '')
opts_chunk$set(
   dev = 'tikz',
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

## ----'comments-to-footnotes'------------------------------------------------------
comments <- unique(semiconductors$comment)
# Count existing comments and remove empty comments
k <- 0
tmp.comments <- character()
for (j in 1:length(comments)) {
   if (comments[j] != "") {
      k <- k + 1
      tmp.comments[k] <- comments[j]
   }
}
# Reset comments
comments <- tmp.comments
# Find their original positions in the semiconductors dataframe
unique.comment.positions <- list()
for (j in 1:length(comments)) {
   unique.comment.positions[[j]] <- which(semiconductors$comment == comments[j])
}
## create footnotemarks
footnotemark <- rep.int(NA, dim(semiconductors)[1])
for (j in 1:length(unique.comment.positions)) {
   footnotemark[unique.comment.positions[[j]]] <- j
   # # replace footnotemark numbers with symbols
   # footnotesymbol <- c("\\ast", "\\dag", "\\ddag", "\\S", "\\P")
   # for (m in 1:max(footnotemark, na.rm = T)) {
   #    footnotemark[which(footnotemark == m)] <- footnotesymbol[m]
   # }
}

## ----'tab-semiconductors-asis', results='asis'------------------------------------
xtab.semiconductors <-
   semiconductors %>%
   mutate(
      formula = ifelse(
         semiconductors$polymorph == "",
         paste0(
            ifelse(
               semiconductors$sctype == "",
               "",
               paste0("$", semiconductors$sctype, "$-")),
            "\\ch{", semiconductors$formula, "}"),
         paste0(
            ifelse(
               semiconductors$sctype == "",
               "",
               paste0("$", semiconductors$sctype, "$-")),
            "\\ch{", semiconductors$formula, "} ", "(", semiconductors$polymorph, ")"))) %>%
   mutate(
      pH = ifelse(
         is.na(semiconductors$pH),
         "\\multicolumn{1}{c}{\\texttt{NA}}",
         semiconductors$pH)) %>%
   mutate(
      pH.ZPC = ifelse(
         is.na(semiconductors$pH.ZPC),
         "\\multicolumn{1}{c}{\\texttt{NA}}",
         semiconductors$pH.ZPC)) %>%
   mutate(
      ref = ifelse(
         semiconductors$ref == "",
         "",
         paste0("\\cite{", semiconductors$ref, "}"))) %>%
   mutate(
      footnotemark = ifelse(
         is.na(footnotemark),
         "",
         paste0("$^{", footnotemark, "}$"))) %>%
   select(formula, class, CB, VB, Eg, pH, pH.ZPC, ref, footnotemark) %>%
   xtable()
caption(xtab.semiconductors) <- paste(
   "Band edge levels at the pH of ZPC for each material.",
   "All band edge potentials vs SHE at the given pH for each semiconductor.",
   "The point of zero surface charge for each material is given (where available)",
   "in the column labelled $\\mathrm{pH_{ZPC}}$.")
label(xtab.semiconductors) <- "tab:semiconductors-asis"
names(xtab.semiconductors) <- c(
   "{Formula}",
   "{Class}",
   "{$E_\\text{CB}$/\\si{\\voltSHE}}",
   "{$E_\\text{VB}$/\\si{\\voltSHE}}",
   "{$E_\\text{g}$/\\si{\\volt}}",
   "{pH}",
   "{pH$_\\text{ZPC}$}",
   "{Ref}",
   "{Note}")
digits(xtab.semiconductors) <- c(
   0, #row.names
   0, #formula
   0, #class
   2, #CB
   2, #VB
   2, #Eg
   2, #pH
   2, #pH.ZPC
   0, #Refs
   0) #Notes
display(xtab.semiconductors) <- c(
   "s", #row.names
   "s", #formula
   "s", #class
   "f", #CB
   "f", #VB
   "f", #Eg
   "f", #pH
   "f", #pH.ZPC
   "s", #Refs
   "s") #Notes
align(xtab.semiconductors) <- c(
   "l",                    #row.names
   "l",                    #formula
   "l",                    #class
   "S[table-format=+1.2]", #CB
   "S[table-format=+1.2]", #VB
   "S[table-format=+1.2]", #Eg
   "S[table-format=2.2]",  #pH
   "S[table-format=2.2]",  #pH.ZPC
   "c",                    #Refs
   "l")                    #Notes
## create-latex-footnotetexts
footnotetext <- comments
# add numbering to each footnote
for (j in 1:length(comments)) {
   footnotetext[j] <- paste0(
      "\\multicolumn{", dim(xtab.semiconductors)[2],
      "}{l}{", "$^{", j, "}$ ", comments[j], "}",
      ifelse(
         j == length(comments),
         "\n",
         "\\\\"))
}
print(
   xtab.semiconductors,
   floating = TRUE,
   floating.environment = "table",
   table.placement = "tbp",
   caption.placement = "top",
   hline.after = NULL,
   add.to.row = list(
      pos = list(
         -1,
         0,
         nrow(xtab.semiconductors),
         nrow(xtab.semiconductors)),
      command = c(
         "\\toprule\n",
         "\\midrule\n",
         "\\bottomrule\n",
         paste(footnotetext, collapse = "\n"))),
      include.rownames = FALSE,
      include.colnames = TRUE,
      type = "latex",
      tabular.environment = "tabular",
      latex.environments = c("center", "small"),
      # note: env small affects the table and footnotetext, but not the caption
      sanitize.text.function = function(x){x},
      math.style.negative = FALSE)

## ----'print-tab-semiconductors-asis', ref.label='tab-semiconductors-asis', eval=FALSE, echo=TRUE----
#  xtab.semiconductors <-
#     semiconductors %>%
#     mutate(
#        formula = ifelse(
#           semiconductors$polymorph == "",
#           paste0(
#              ifelse(
#                 semiconductors$sctype == "",
#                 "",
#                 paste0("$", semiconductors$sctype, "$-")),
#              "\\ch{", semiconductors$formula, "}"),
#           paste0(
#              ifelse(
#                 semiconductors$sctype == "",
#                 "",
#                 paste0("$", semiconductors$sctype, "$-")),
#              "\\ch{", semiconductors$formula, "} ", "(", semiconductors$polymorph, ")"))) %>%
#     mutate(
#        pH = ifelse(
#           is.na(semiconductors$pH),
#           "\\multicolumn{1}{c}{\\texttt{NA}}",
#           semiconductors$pH)) %>%
#     mutate(
#        pH.ZPC = ifelse(
#           is.na(semiconductors$pH.ZPC),
#           "\\multicolumn{1}{c}{\\texttt{NA}}",
#           semiconductors$pH.ZPC)) %>%
#     mutate(
#        ref = ifelse(
#           semiconductors$ref == "",
#           "",
#           paste0("\\cite{", semiconductors$ref, "}"))) %>%
#     mutate(
#        footnotemark = ifelse(
#           is.na(footnotemark),
#           "",
#           paste0("$^{", footnotemark, "}$"))) %>%
#     select(formula, class, CB, VB, Eg, pH, pH.ZPC, ref, footnotemark) %>%
#     xtable()
#  caption(xtab.semiconductors) <- paste(
#     "Band edge levels at the pH of ZPC for each material.",
#     "All band edge potentials vs SHE at the given pH for each semiconductor.",
#     "The point of zero surface charge for each material is given (where available)",
#     "in the column labelled $\\mathrm{pH_{ZPC}}$.")
#  label(xtab.semiconductors) <- "tab:semiconductors-asis"
#  names(xtab.semiconductors) <- c(
#     "{Formula}",
#     "{Class}",
#     "{$E_\\text{CB}$/\\si{\\voltSHE}}",
#     "{$E_\\text{VB}$/\\si{\\voltSHE}}",
#     "{$E_\\text{g}$/\\si{\\volt}}",
#     "{pH}",
#     "{pH$_\\text{ZPC}$}",
#     "{Ref}",
#     "{Note}")
#  digits(xtab.semiconductors) <- c(
#     0, #row.names
#     0, #formula
#     0, #class
#     2, #CB
#     2, #VB
#     2, #Eg
#     2, #pH
#     2, #pH.ZPC
#     0, #Refs
#     0) #Notes
#  display(xtab.semiconductors) <- c(
#     "s", #row.names
#     "s", #formula
#     "s", #class
#     "f", #CB
#     "f", #VB
#     "f", #Eg
#     "f", #pH
#     "f", #pH.ZPC
#     "s", #Refs
#     "s") #Notes
#  align(xtab.semiconductors) <- c(
#     "l",                    #row.names
#     "l",                    #formula
#     "l",                    #class
#     "S[table-format=+1.2]", #CB
#     "S[table-format=+1.2]", #VB
#     "S[table-format=+1.2]", #Eg
#     "S[table-format=2.2]",  #pH
#     "S[table-format=2.2]",  #pH.ZPC
#     "c",                    #Refs
#     "l")                    #Notes
#  ## create-latex-footnotetexts
#  footnotetext <- comments
#  # add numbering to each footnote
#  for (j in 1:length(comments)) {
#     footnotetext[j] <- paste0(
#        "\\multicolumn{", dim(xtab.semiconductors)[2],
#        "}{l}{", "$^{", j, "}$ ", comments[j], "}",
#        ifelse(
#           j == length(comments),
#           "\n",
#           "\\\\"))
#  }
#  print(
#     xtab.semiconductors,
#     floating = TRUE,
#     floating.environment = "table",
#     table.placement = "tbp",
#     caption.placement = "top",
#     hline.after = NULL,
#     add.to.row = list(
#        pos = list(
#           -1,
#           0,
#           nrow(xtab.semiconductors),
#           nrow(xtab.semiconductors)),
#        command = c(
#           "\\toprule\n",
#           "\\midrule\n",
#           "\\bottomrule\n",
#           paste(footnotetext, collapse = "\n"))),
#        include.rownames = FALSE,
#        include.colnames = TRUE,
#        type = "latex",
#        tabular.environment = "tabular",
#        latex.environments = c("center", "small"),
#        # note: env small affects the table and footnotetext, but not the caption
#        sanitize.text.function = function(x){x},
#        math.style.negative = FALSE)

## ----'gitR-info', echo=FALSE, results='markup', cache=FALSE-----------------------
# status(repo)

## ----'R-session-info', echo=FALSE, results='asis', cache=FALSE--------------------
toLatex(sessionInfo(), locale=F)

## ----'pdflatex-version', echo=FALSE, results='asis'-------------------------------
latex.version.text <- system(command = "pdflatex -version", intern = TRUE)
# quick fixes: replace "\o" with "o", and remove all empty rows in latex.version.text
cat(paste0("\\noindent\n", paste(sub("\\\\o", "o", latex.version.text[which(latex.version.text != "")]), collapse = "\\\\\n")))

