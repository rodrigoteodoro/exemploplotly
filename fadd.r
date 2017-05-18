library(readr)
fadd <- read_csv("~/Área de Trabalho/fadd.csv", 
                 col_names = FALSE)
colnames(fadd) <- c("data", 'tam', 'tempo')
fadd$tot <- fadd$tam/fadd$tempo*8/1024
library(plotly)
plot_ly(
  x = fadd$data,
  y = fadd$tot,
  name = "Velocidade",
  type = "scatter"
) 
#---
fadd=within(fadd, {
  y=NA
  y[tot < 1800] = 'Baixa'
  y[tot >= 1800 & tot <=3000] = 'Média'
  y[tot > 3000] = 'Alta'
})

pal <- c("red", "blue", "green")
pal <- setNames(pal, c("Baixa", "Média", "Alta"))
plot_ly(data = fadd, x = fadd$data, y = fadd$tot, color = fadd$y, colors = pal)
# ---
f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f"
)
x <- list(
  title = "Período",
  titlefont = f
)
y <- list(
  title = "Velocidade(Kbits/s)",
  titlefont = f
)
plot_ly(data = fadd, x = fadd$data, y = fadd$tot, color = fadd$y, colors = pal) %>% layout(xaxis = x, yaxis = y)