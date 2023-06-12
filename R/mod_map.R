#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom ggiraph girafeOutput
mod_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = 'mainplot',
      girafeOutput(ns("plot1"), height = "100%")
    )

  )
}

#' map Server Functions
#'
#' @noRd
mod_map_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    p <- fct_create_map()

    output$plot1 <- renderGirafe({
      return(girafe(

        code = print(p),
        options = list(opts_sizing(rescale = TRUE)),
        bg = '#000000'
      ))
    })


  })
}

## To be copied in the UI
# mod_map_ui("map_1")

## To be copied in the server
# mod_map_server("map_1")
