# Each semiconductor is specified via a call to `semiconductor_raw`
# that specifies the band gap properties and refs, comments, etc.
semiconductors <- data.frame()

semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "ZrO2",
            class = "oxide",
            CB = refelectrodes::as.SHE(-3.41, "AVS"),
            Eg = 5.00,
            pH.ZPC = 6.70,
            pH = 6.70,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "Ta2O5",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.33, "AVS"),
            Eg = 4.00,
            pH.ZPC = 2.90,
            pH = 2.90,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "KTaO3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-3.57, "AVS"),
            Eg = 3.50,
            pH.ZPC = 8.55,
            pH = 8.55,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "SnO2",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.50, "AVS"),
            Eg = 3.50,
            pH.ZPC = 4.30,
            pH = 4.30,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "NiO",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.00, "AVS"),
            Eg = 3.50,
            pH.ZPC = 10.30,
            pH = 10.30,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "SrTiO3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-3.24, "AVS"),
            Eg = 3.40,
            pH.ZPC = 8.60,
            pH = 8.60,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "BaTiO3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.58, "AVS"),
            Eg = 3.30,
            pH.ZPC = 9.00,
            pH = 9.00,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "ZnO",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.19, "AVS"),
            Eg = 3.20,
            pH.ZPC = 8.80,
            pH = 8.80,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "TiO2",
            polymorph = "anatase",
            sctype = "n",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.21, "AVS"),
            Eg = 3.20,
            pH.ZPC = 5.80,
            pH = 5.80,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "TiO2",
            polymorph = "rutile",
            sctype = "n",
            class = "oxide",
            CB = refelectrodes::as.SHE(-1.0, "SCE",
                                electrolyte = "KCl(aq)",
                                concentration = "saturated"),
            Eg = 3.0,
            pH = 13.00,
            ref = "Burnside1999"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "CuTiO3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.32, "AVS"),
            Eg = 2.99,
            pH.ZPC = 7.29,
            pH = 7.29,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "FeTiO3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.29, "AVS"),
            Eg = 2.80,
            pH.ZPC = 6.30,
            pH = 6.30,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "In2O3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-3.88, "AVS"),
            Eg = 2.80,
            pH.ZPC = 8.64,
            pH = 8.64,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "WO3",
            class = "oxide",
            CB = refelectrodes::as.SHE(-5.24, "AVS"),
            Eg = 2.70,
            pH.ZPC = 0.43,
            pH = 0.43,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "CdFe2O4",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.68, "AVS"),
            Eg = 2.30,
            pH.ZPC = 7.22,
            pH = 7.22,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "Fe2O3",
            polymorph = "hematite",
            sctype = "n",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.78, "AVS"),
            Eg = 2.20,
            pH.ZPC = 8.60,
            pH = 8.60,
            ref = "Xu2000,Nozik1978"))
# source unclear
# semiconductors <-
#    rbind(semiconductors,
#          semiconductor_row(
#             formula = "Fe2O3",
#             polymorph = "maghemite",
#             class = "oxide",
#             CB = refelectrodes::as.SHE(0.29, "SHE"),
#             Eg = 2.3,
#             pH.ZPC = NA,
#             ref = ""))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "CdO",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.61, "AVS"),
            Eg = 2.20,
            pH.ZPC = 11.60,
            pH = 11.60,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "Cu2O",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.22, "AVS"),
            Eg = 2.20,
            pH.ZPC = 8.53,
            pH = 8.53,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "CuO",
            class = "oxide",
            CB = refelectrodes::as.SHE(-4.96, "AVS"),
            Eg = 1.70,
            pH.ZPC = 9.50,
            pH = 9.50,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "MoS2",
            class = "sulfide",
            CB = refelectrodes::as.SHE(-4.73, "AVS"),
            Eg = 1.17,
            pH.ZPC = 2.00,
            pH = 2.00,
            Nernstian = FALSE,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "ZnS",
            class = "sulfide",
            CB = refelectrodes::as.SHE(-3.46, "AVS"),
            Eg = 3.60,
            pH.ZPC = 1.70,
            pH = 1.70,
            Nernstian = FALSE,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "CdS",
            class = "sulfide",
            CB = refelectrodes::as.SHE(-3.98, "AVS"),
            Eg = 2.40,
            pH.ZPC = 2.00,
            pH = 2.00,
            Nernstian = FALSE,
            ref = "Xu2000"))
# semiconductors <-
#    rbind(semiconductors,
#          semiconductor_row(
#             formula = "GaN",
#             class = "nitride",
#             CB = refelectrodes::as.SHE(-0.5, "SHE"),
#             Eg = 3.5,
#             pH = NA,
#             Nernstian = FALSE,
#             ref = "Gorczyca2010",
#             comment = "Band gap value from \\cite{Gorczyca2010}. $E_\\text{CB}$ value from advisor."))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "Ta3N5",
            class = "nitride",
            VB = refelectrodes::as.SHE(-6.02, "AVS"),
            CB = refelectrodes::as.SHE(-3.92, "AVS"),
            pH = 1.0,
            pH.ZPC = 1.0,
            sctype = "n",
            Nernstian = TRUE,
            ref = "Chun2003",
            comment = "VB and CB from UPS measurement. Flatband potential showed a Nernstian dependence on pH."))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "TaON",
            class = "oxynitride",
            sctype = "n",
            VB = refelectrodes::as.SHE(-6.6, "AVS"),
            CB = refelectrodes::as.SHE(-4.1, "AVS"),
            pH = 2.5,
            pH.ZPC = 2.5,
            Nernstian = TRUE,
            ref = "Chun2003",
            comment = "VB and CB from UPS measurement. Flatband potential expected to be a linear function of pH."))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "SiC",
            class = "carbide",
            xtal.size = "nanowires",
            VB = refelectrodes::as.SHE(2.34, "SHE"),
            Eg = 2.8,
            pH = 14,
            Nernstian = FALSE,
            ref = "Chiu2009",
            comment = "Band gap from diffuse reflectance spectroscopy, edges from Mott-Schottky."))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "PbS",
            class = "sulfide",
            CB = refelectrodes::as.SHE(-4.74, "AVS"),
            Eg = 0.37,
            pH.ZPC = 1.40,
            pH = 1.40,
            Nernstian = FALSE,
            ref = "Xu2000"))
semiconductors <-
   rbind(semiconductors,
         semiconductor_row(
            formula = "CdSe",
            class = "selenide",
            CB = refelectrodes::as.SHE(-1.0, "SHE"),
            Eg = 1.7,
            pH = 12,
            transition = "excitonic",
            sctype = "n",
            Nernstian = FALSE,
            ref = "Liu1993,Strehlow1973"))

# sort the semiconductors dataframe, by band gaps (decreasing) and CB (decreasing)
semiconductors <-
   semiconductors[order(semiconductors$Eg, semiconductors$CB, decreasing = TRUE), ]
# reset the rownames (numbering) for the sake of prettiness
row.names(semiconductors) <- seq(1, dim(semiconductors)[1])

# put the semiconductors dataframe in /data
# (use overwrite = TRUE to overwrite)
usethis::use_data(semiconductors)

# Workflow with devtools data-functions described in this blog:
# http://www.davekleinschmidt.com/r-packages/
# use_data() function moved from devtools to usethis
# https://stackoverflow.com/a/54424764/1198249
