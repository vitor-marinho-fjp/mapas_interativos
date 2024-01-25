
# Tutorial: Mapas Interativos no R

Este tutorial fornece um guia passo a passo para criar mapas interativos no R utilizando as bibliotecas `ggplot2`, `sf`, `viridis`, e `plotly`. O exemplo apresentado utiliza dados sobre o Índice de Gini dos municípios de Minas Gerais em 2020, calculado com base no PIB per capita.

## Pré-requisitos

Certifique-se de ter instalado as seguintes bibliotecas:

```R
install.packages(c("tidyverse", "sf", "viridis", "ggplot2", "plotly"))
```

## Passos

1. **Carregar as bibliotecas necessárias:**
   ```R
   library(tidyverse)
   library(sf)
   library(viridis)
   library(ggplot2)
   library(plotly)
   ```

2. **Ler os dados do município:**
   ```R
   mun <- read_municipality(code_muni = "MG", year = 2010)
   ```

3. **Converter a coluna de código do município para double:**
   ```R
   gini_municipios$code_muni <- as.double(gini_municipios$code_muni)
   ```

4. **Juntar coordenadas para criar o mapa:**
   ```R
   gini_municipios <- left_join(gini_municipios, mun, by = 'code_muni')
   ```

5. **Criar o objeto ggplot:**
   ```R
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
   ```

6. **Converter o gráfico ggplot para plotly com hovertext:**
   ```R
   interactive_plot <- ggplotly(ggplot_obj, tooltip = "text")
   ```

7. **Exibir o gráfico interativo:**
   ```R
   print(interactive_plot)
   ```

Agora você possui um mapa interativo dos municípios de Minas Gerais com informações sobre o Índice de Gini. Sinta-se à vontade para personalizar o código conforme suas necessidades.

---
**Nota:** Certifique-se de ajustar o código de acordo com a estrutura dos seus dados e quaisquer personalizações desejadas.
```
