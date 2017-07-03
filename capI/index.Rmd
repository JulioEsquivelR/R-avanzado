---
title       : R avanzado  
subtitle    : Capítulo I
author      : Kevin Pérez C, Profesor Auxiliar
job         : Departamento de Matemáticas y Estadística - Universidad de Córdoba
logo        : unicordoba3.png
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
widescreen  : true
smaller     : true
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax, bootstrap, quiz, shiny, interactive]            
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---


## Manejo de directorios de trabajo 

- Un componente básico de trabajar con datos es conocer su directorio de trabajo
- Los dos comandos principales son ```getwd()``` y ```setwd()```. 
- Tenga en cuenta las rutas relativas vs las absolutas
   + __Relativa__ - ```setwd("./data")```, ```setwd("../")```
   + __Absoluta__ - ```setwd("/Users/name/data/")```
- Diferencia importante en Windows ```setwd("C:\\Users\\Name\\Downloads")```

---
