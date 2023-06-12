#' about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_about_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "container",
      div(class = "about-main",
        includeMarkdown(here::here('inst/app/www/about.md')),
          actionButton(ns('btn-map'), class = 'green-button', label = "Interactive Map"),
          actionButton(ns('btn-dashboard'), class = 'pink-button', label = "Dashboard")


      )

    )


  )
}

#' about Server Functions
#'
#' @noRd
mod_about_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_about_ui("about_1")

## To be copied in the server
# mod_about_server("about_1")
