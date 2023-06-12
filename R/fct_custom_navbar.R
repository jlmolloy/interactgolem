#' custom_navbar
#'
#' @description Adds a logo to the navbar-brand div
#' @importFrom shiny navbarPage
#' @importFrom shiny tags
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
custom_navbar <- function(...) {
  # Call the original navbarPage function
  navbar <- navbarPage('test')


  navbar$children[[1]]$children[[1]]$children[[1]] <-
    list(tags$a(href='http://interact-hub.com',
                tags$img(src="www/interact-logo.png", height='40px'),
                class='navbar-brand'))

  navbar
}
