#' @name semiconductors
#' @title Band gaps and band edge potentials for semiconductors
#' @description A dataset listing band gaps and band edge potentials
#'     for semiconductor materials. Sourced from primary literature sources.
#' @docType data
#' @format A data frame with 27 rows and 14 variables:
#' \describe{
#'   \item{id}{label used for uniquely identifying each row}
#'   \item{formula}{The compound's chemical formula.}
#'   \item{polymorph}{Polymorph, e.g., anatase, brookite.}
#'   \item{xtal.size}{Crystallite size, e.g., bulk, micro, nano.}
#'   \item{sctype}{Semiconductor type, i.e., n or p.}
#'   \item{class}{Material class, e.g., oxide, sulfide, nitride.}
#'   \item{CB}{Conduction band edge potential/V(SHE).}
#'   \item{VB}{Valence band edge potential/V(SHE).}
#'   \item{Eg}{Band gap/V(SHE)}
#'   \item{transition}{Transition type: direct, indirect, etc.}
#'   \item{pH}{The pH at which the reported CB/VB occurs.}
#'   \item{pH.ZPC}{The pH at which the material's surface is neutral.}
#'   \item{ref}{Bibtex reference key. See bib-file in /vignettes/references.bib}
#'   \item{comment}{Free-form comment.}
#' }
#' @author Taha Ahmed
"semiconductors"
