#' create_map
#'
#' @description Create a new map with ggiraph
#'
#' @return The return value, if any, from executing the function.
#' @import tidyverse
#' @import ggiraph
#' @import sf
#' @import dplyr
#' @noRd
#'
#'

fct_create_map <- function(){
  library(tidyverse)
  library(dplyr)
  library(ggiraph)
    hex_gpkg <- here::here('data/uk-hex-cartogram/geopackages/LocalAuthorities-uppertier.gpkg')
    hex_layers <- sf::st_layers(hex_gpkg)
    hex_sf <- sf::st_read(hex_gpkg, layer = '6 UTLA-2021')
    hex_bg <- sf::st_read(hex_gpkg, layer = '7 Background')
    hex_labels <- sf::st_read(hex_gpkg, layer = '1 Group labels')

    ch_data <- readr::read_csv(here::here('data/am_companies_by_sic.csv'))
    ch_data$RegAddress.PostCode <- ch_data$RegAddress.PostCode %>% gsub(pattern = ' ', replacement = '')
    nspl <- readr::read_csv(here::here('data/NSPL_MAY_2022_UK.csv')) %>% dplyr::select(., c('pcd','pcd2','pcds','laua','lat','long'))
    nspl$pcd <- nspl$pcd %>% gsub(pattern = ' ', replacement = '')
    t <- dplyr::left_join(ch_data, nspl, by = c('RegAddress.PostCode' ='pcd'))

    companies_by_lau <- t %>% group_by(laua) %>%
      summarise(
        company_n = n()
      )


    new_uksf <- hex_sf %>% left_join(companies_by_lau, by = c('cua.code'='laua'))
    label_geom <- new_uksf %>% group_by(Group.labe) %>% sample_n(1)



    p <- ggplot2::ggplot()+
      geom_sf(data = hex_bg, fill = 'lightgrey')+
      geom_sf_interactive(data = new_uksf, aes(fill = company_n, tooltip = paste(RegionNati, Group.labe, cua.name, company_n, sep = '\n' ), data_id = cua.name), show.legend = TRUE)+
      scale_fill_distiller(type = 'seq', palette = 1, direction = 2, na.value = 'white') +
      labs(fill = 'Count', title = 'Advanced Manufacturing Companies by LA') +
      theme( panel.background = element_rect(fill= '#000000'),
             plot.background = element_rect(fill='#000000', color=NA),
             legend.background = element_rect(fill = "#000000"), legend.title = element_text(color = 'white'),
             legend.text = element_text(color = 'white'),
             plot.title = element_text(color = 'white'),
             plot.margin = margin(0, 0, 0, 0, "cm"),
             strip.background = element_rect(fill = '#000000')
      )

return(p)
}
