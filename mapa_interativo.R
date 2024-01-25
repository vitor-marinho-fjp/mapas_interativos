# Carregar as bibliotecas necessárias
library(tidyverse)
library(sf)
library(viridis)
library(ggplot2)
library(plotly)

# Ler os dados do município
mun <- read_municipality(code_muni = "MG", year = 2010)

# Converter a coluna de código do município para double
gini_municipios$code_muni <- as.double(gini_municipios$code_muni)

# Juntar coordenadas para criar o mapa
gini_municipios <- left_join(gini_municipios, mun, by = 'code_muni')

# Criar o objeto ggplot
ggplot_obj <- gini_municipios %>% 
  ggplot() +
  geom_sf(data = ., aes(fill = gini, text = paste("Município: ", NM_MUNICIP, "<br>Índice Gini: ", gini))) +
  scale_fill_viridis_c(option = 15, begin = 0.2, end = 0.8, name = 'Gini') +
  theme(panel.grid = element_line(colour = "transparent"),
        panel.background = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) +
  labs(title = "Índice de Gini 2020 dos Municípios de MG",
       subtitle = 'Calculado com base no PIB per capita',
       caption = 'Fonte: Elaboração própria', size = 8) +
  annotation_scale(location = "bl", width_hint = 0.3) + 
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.3, "in"), pad_y = unit(0.3, "in"),
                         style = north_arrow_fancy_orienteering)

# Converter o gráfico ggplot para plotly com hovertext
interactive_plot <- ggplotly(ggplot_obj, tooltip = "text")

# Exibir o gráfico interativo
print(interactive_plot)
