#' Plot band gaps
#'
#' Band energies and gaps of user-selectable semiconductors using R base graphics.
#' There is no practical way to return a plot object using base graphics, so
#' this function does not return anything, it just creates the plot.
#' It is probably well-suited for use in a Rmd or LaTeX document.
#' The generated plot requires the LaTeX packages siunitx and chemformula to
#' typeset the text labels.
#'
#' @param materials a subset of \code{\link{semiconductors}} dataframe
#' @param secondary.scale select reference electrode for the secondary y-axis
#'     Default secondary scale is AVS (vacuum scale). Set this argument to empty
#'     string to disable the secondary scale.
#' @param dev used for testing during development. Setting to TRUE enables extra
#'     plot elements such as x-axis and grids to support development.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' plot_bandgaps(bandgaps::semiconductors %>%
#'    filter(class == "oxide") %>%
#'    filter(str_detect(formula, "Fe")),
#'    secondary.scale = "AVS")
#' plot_bandgaps(bandgaps::semiconductors %>%
#'    filter(class == "oxide") %>%
#'    filter(str_detect(formula, "O2")))
#' }
plot_bandgaps <- function(materials, secondary.scale = "AVS", dev = FALSE) {
   ## stuff to add/figure out:
   # + recalculating band energies based on supplied pH value (we're gonna need a function for pH-recalc)
   # + water redox lines should have labels

   disable.secondary.scale <- FALSE
   if (secondary.scale == "") {
      # user explicitly set it empty
      disable.secondary.scale <- TRUE
   }

   ## x-step
   # horizontal step between each band gap
   xstep <- 1
   materials$x <- seq(0.4, dim(materials)[1], by = xstep)
   # width of CB and VB "shelf"
   xshelf.width <- 0.4 * xstep
   materials$xshelf <- materials$x - xshelf.width

   ## plot settings
   text.main.size <- 0.7
   text.small.size <- 0.65
   bandgap.line.width <- 2
   bandgap.line.type <- "l"

   # make room for right-hand side y-axis
   graphics::par(mar = c(2, 5, 2, 5))

   # setup the y-axis using the y-max and y-min in materials
   p <- graphics::plot(
      x = range(materials$x),
      y = range(c(materials$CB, materials$VB)),
      type = "n",
      axes = FALSE,
      # flip y-axis (SHE)
      ylim = rev(range(c(materials$CB, materials$VB))),
      # make room at the left-hand side of x-axis
      # xlim = range(c(min(materials$x - xstep), materials$x)),
      # is all this room necessary?
      xlim = range(c(0, materials$x)),
      xlab = "",
      ylab = "",
      bty = "n")

   # left-hand y-axis (always SHE)
   graphics::axis(
      2,
      at = pretty(range(min(materials$CB), max(materials$VB))),
      labels =
         paste0("\\num{",
                formatC(pretty(range(min(materials$CB), max(materials$VB))),
                        format = "f",
                        digits = 2),
                "}"),
      las = 1,
      cex.axis = text.main.size)
   graphics::mtext(
      "E(SHE)/V",
      side = 2,
      line = 3,
      las = 0,
      cex = text.main.size)

   if (dev == TRUE) {
      # grid lines
      graphics::grid(lty = "dotted")
      graphics::axis(
         1,
         las = 1,
         cex.axis = text.main.size)
   }

   if (!disable.secondary.scale) {
      # right-hand y-axis (secondary scale)
      graphics::axis(
         4,
         at =
            refelectrodes::as.SHE(
               pretty(
                  range(
                     # convert from SHE to secondary scale
                     refelectrodes::from.SHE(min(materials$CB), refelectrodes::RefCanonicalName(secondary.scale)),
                     refelectrodes::from.SHE(max(materials$VB), refelectrodes::RefCanonicalName(secondary.scale))
                  )
               ),
               refelectrodes::RefCanonicalName(secondary.scale)),
         labels =
            paste0("\\num{",
                   formatC(
                      pretty(
                         range(
                            refelectrodes::from.SHE(min(materials$CB), refelectrodes::RefCanonicalName(secondary.scale)),
                            refelectrodes::from.SHE(max(materials$VB), refelectrodes::RefCanonicalName(secondary.scale))
                         )
                      ),
                      format = "f",
                      digits = 2),
                   "}"),
         cex.axis = text.main.size,
         las = 1)
      # # mtext() does not supporting rotating the title (no srt arg)
      # # so we use this hack to rotate and place text outside the plot
      # # https://stackoverflow.com/a/42034961
      # corners <- par("usr") # gets the four corners of the plot
      # par(xpd = TRUE) # draw outside the plot area
      # text(x = corners[2] + 0.25,
      #      y = mean(corners[3:4]),
      #      paste0("E(", refelectrodes::RefCanonicalName(secondary.scale), ")/V"),
      #      srt = 270,
      #      cex = text.main.size)
      graphics::mtext(
         paste0("E(", refelectrodes::RefCanonicalName(secondary.scale), ")/V"),
         side = 4,
         line = 3,
         las = 0,
         cex = text.main.size)
   }

   ## Water redox potential lines (plot only if inside plot y-range)
   waterox.pot <- 0 # /V
   waterre.pot <- 1.23 # /V
   # if water oxidation potential is inside the plot y range
   if ((waterox.pot <= max(range(c(materials$CB, materials$VB)))) &
       (waterox.pot >= min(range(c(materials$CB, materials$VB))))) {
      graphics::abline(h = waterox.pot, col = "red", lty = "dashed")
   }
   # if water reduction potential is inside the plot y range
   if ((waterre.pot <= max(range(c(materials$CB, materials$VB)))) &
       (waterre.pot >= min(range(c(materials$CB, materials$VB))))) {
      graphics::abline(h = waterre.pot, col = "blue", lty = "dashed")
   }

   # # Water oxidation potential line (remember to account for pH)
   # graphics::abline(abline(h = 0, col = "gray", lty = "dashed")
   # # Water reduction potential line (remember to account for pH)
   # graphics::abline(abline(h = 1.23, col = "gray", lty = "dashed")

   # draw the diagram elements for each material
   # consider adding an arg to this function that lets the user disable the different colouring for non-Nernstian SCs
   colour.nonNernstian <- "darkgray"
   for (i in 1:length(materials$CB)) {
      # non-Nernstian semiconductors should be distinguished visually
      if (!materials$Nernstian[i]) {
         # vertical lines
         graphics::lines(c(materials$x[i], materials$x[i]), c(materials$CB[i], materials$VB[i]),
                         type = bandgap.line.type,
                         lwd = bandgap.line.width,
                         col = colour.nonNernstian)
         # CB shelf
         graphics::lines(c(materials$xshelf[i], materials$x[i]), c(materials$CB[i], materials$CB[i]),
                         type = bandgap.line.type,
                         lwd = bandgap.line.width,
                         col = colour.nonNernstian)
         # VB shelf
         graphics::lines(c(materials$xshelf[i], materials$x[i]), c(materials$VB[i], materials$VB[i]),
                         type = bandgap.line.type,
                         lwd = bandgap.line.width,
                         col = colour.nonNernstian)
      } else {
         # vertical lines
         graphics::lines(c(materials$x[i], materials$x[i]), c(materials$CB[i], materials$VB[i]),
                         type = bandgap.line.type,
                         lwd = bandgap.line.width)
         # CB shelf
         graphics::lines(c(materials$xshelf[i], materials$x[i]), c(materials$CB[i], materials$CB[i]),
                         type = bandgap.line.type,
                         lwd = bandgap.line.width)
         # VB shelf
         graphics::lines(c(materials$xshelf[i], materials$x[i]), c(materials$VB[i], materials$VB[i]),
                         type = bandgap.line.type,
                         lwd = bandgap.line.width)
      }
      # chemical formula
      graphics::text(x = mean(c(materials$x[i], materials$xshelf[i])),
                     y = materials$CB[i],
                     labels = paste0("\\ch{", materials$formula[i], "}"),
                     adj = c(0.5, -0.8),
                     cex = 0.7)
      # Eg value
      graphics::text(x = materials$x[i],
                     y = mean(c(materials$CB[i], materials$VB[i])),
                     labels = paste0("\\SI{", materials$Eg[i], "}{\\volt}"),
                     adj = c(0.5, -0.8), # rotate around a point below the baseline, centered along length of string
                     srt = 90,
                     cex = 0.65)
   }
}









