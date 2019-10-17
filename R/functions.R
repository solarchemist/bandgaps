#' Collect semiconductor properties into df row ready to add to dataset
#'
#' IMPORTANT: always use SHE scale for all potentials.
#' May I suggest you use \code{\link[refelectrodes]{as.SHE}} for this purpose.
#'
#' @param formula mandatory. The compound's chemical formula.
#' @param polymorph optional. Polymorph name, e.g., anatase, brookite.
#' @param xtal.size optional, defaults to "bulk". Crystallite size.
#' @param sctype optional. Semiconductor type, i.e., n or p.
#' @param class optional, but recommended. Material class, e.g., oxide, sulfide, nitride
#' @param CB optional, but make sure that any two of: CB, VB or Eg are specified.
#' @param VB optional, but make sure that any two of: CB, VB or Eg are specified.
#' @param Eg optional, but make sure that any two of: CB, VB or Eg are specified.
#' @param transition optional, transition type: direct, indirect, etc.
#' @param pH optional, but recommended, allowed to be NA. The pH value at the CB/VB.
#' @param pH.ZPC optional. pH at which surface charge is neutral.
#' @param Nernstian optional. Is set to TRUE if given explicitly, else set to FALSE. Except if class is oxide then set to TRUE regardless.
#' @param ref mandatory. BibTeX reference string. Separate multiple refs with commas.
#' @param comment optional.
#'
#' @return single-row dataframe ready to be incorporated into a semiconductors dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' semiconductor_row(formula="CdS", CB=refelectrodes::as.SHE(-3.98, "AVS"),
#'                   Eg=2.40, pH=2.00, ref="Xu2000")
#' }
semiconductor_row <-
   function (formula,
             polymorph = "",
             xtal.size = "bulk",
             sctype = "",
             class = "",
             CB = NA,
             VB = NA,
             Eg = NA,
             transition = "",
             pH = NA,
             pH.ZPC = NA,
             Nernstian = "",
             ref,
             comment = "") {
      ### Check state of arguments for problems
      # 1. check that CB/VB are numeric -- not implemented yet
      # 2. Check that formula makes sense chemically(?) -- not implemented yet
      # 3. other checks...

      # 3 ## handle Nernstian arg
      if (class == "oxide") Nernstian <- TRUE
      # reset string "TRUE" to boolean TRUE
      if (Nernstian == TRUE || Nernstian == "TRUE" || Nernstian == "true" || Nernstian == "True") {
         Nernstian <- TRUE
      } else {
         # any other input should be considered Nernstian = FALSE
         Nernstian <- FALSE
      }

      # 3 ## handle multiple references gracefully
      if (length(ref) > 1) {
         # collapse string and separate with commas
         ref <- paste(ref, collapse = ",", sep = "")
      }

      # Given any to of: CB, VB, Eg, calculate the third
      if (!is.na(CB)) {
         # if CB specified
         if (!is.na(VB)) {
            # if both CB and VB specified
            # ==> Calculate Eg
            Eg <- VB - CB
         }
         if (!is.na(Eg)) {
            # if both CB and Eg specified
            # ==> Calculate VB
            VB <- Eg + CB
         }
      } else {
         # if CB not specified
         if (!is.na(VB)) {
            # if VB specified
            if (!is.na(Eg)) {
               # if both VB and Eg specified
               # ==> Calculate CB
               CB <- VB - Eg
            } else {
               # if both CB and Eg not specified
               stop(paste("Neither CB nor Eg specified.",
                          "Please specify either CB or Eg in addition to VB."))
            }
         } else {
            # if both VB and CB not specified
            stop(paste("Neither VB nor CB specified.",
                       "Please specify either VB or Eg in addition to CB."))
         }
      }

      # build up a row (one semiconductor with its properties)
      scrow <-
                    # form a unique label for sorting and other db operations
         data.frame(id         = paste0(formula, "-", polymorph),
                    formula    = formula,
                    polymorph  = polymorph,
                    xtal.size  = xtal.size,
                    sctype     = sctype,
                    class      = class,
                    CB         = CB,
                    VB         = VB,
                    Eg         = Eg,
                    transition = transition,
                    pH         = pH,
                    pH.ZPC     = pH.ZPC,
                    Nernstian  = Nernstian,
                    ref        = ref,
                    comment    = comment,
                    stringsAsFactors = FALSE)
      # fix trailing dash in unique label
      scrow$id <- sub("-$", "", scrow$id)

      return(scrow)
   }







