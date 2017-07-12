---
title       : R avanzado  
subtitle    : Limpieza de datos 
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

## Los datos 

<br> 

<img class=center src= assets/img/img1.png height=450 weight=800 />


--- 

## Acerca de la limpieza 

<br> 

<img class=center src= assets/img/img2.png height=450 weight=600 />

---

## Los datos fuente 

- El extraño archivo binario que su máquina imprime
- El archivo Excel no formateado con 10 hojas de trabajo que le envió su compañero de empresa 
- Los complicados datos `JSON` que obtiene al conectarse a la API de _Twitter_
- Los números ingresados manualmente que se recolectan mirando a través de un microscopio

---

## Los datos ordenados 

- Cada variable que se mide debe estar en una columna
- Cada observación diferente de esa variable debe estar en una fila diferente
- Debe haber una tabla para cada "tipo" de variable
- Si se tienen varias tablas, deben incluir una columna en cada tabla que les permita estar vinculadas

---

## Los datos ordenados 
<br> 

<img class=center src= assets/img/img3.png height=450/>

- Cumple con los tres primeros conceptos 

---

## Los datos ordenados 

<br> 

<img class=center src= assets/img/img4.png height=450/>

- ¿Falla en alguno de los conceptos? 

---

## Ancho vs. largo 

<img class=center src= assets/img/img5.png height=450/>

---

## Explorando datos 


```r
head(iris, 3)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
```

```r
tail(iris, 3)
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
## 148          6.5         3.0          5.2         2.0 virginica
## 149          6.2         3.4          5.4         2.3 virginica
## 150          5.9         3.0          5.1         1.8 virginica
```

---

## Explorando datos

```r
str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

---


## Explorando datos


```r
dplyr::glimpse(iris)
```

```
## Observations: 150
## Variables: 5
## $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9,...
## $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1,...
## $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5,...
## $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1,...
## $ Species      <fctr> setosa, setosa, setosa, setosa, setosa, setosa, ...
```

---


## Explorando datos

```r
summary(iris)
```

```
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    :50  
##  versicolor:50  
##  virginica :50  
##                 
##                 
## 
```

---

## Explorando datos

```r
# Clase del objeto
class(iris)
```

```
## [1] "data.frame"
```

```r
# Dimensiones 
dim(iris)
```

```
## [1] 150   5
```

```r
# Nombres
#names(iris)
```

---

## El paquete `tidyr`

- Un paquete escrito por _Hadley Wickham_

- Aplica los principios de la data ordenada 

- Es un conjunto de pequeñas funciones 

---

## El paquete `tidyr`

La función más importante en `tidy` es `gather()`. Debe utilizarse cuando se tienen columnas que no son variables y se desea contraerlas en pares _clave-valor._ Sus parámetros más importantes son:

- _data:_ Un data frame
- _key:_ Nombre simple de la nueva columna clave
- _value:_ Nombre simple de los nuevos valores de columna 

---

## El paquete `tidyr`


```r
mini_iris <- iris[c(1, 51, 101), ]
mini_iris
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1            5.1         3.5          1.4         0.2     setosa
## 51           7.0         3.2          4.7         1.4 versicolor
## 101          6.3         3.3          6.0         2.5  virginica
```

---

## El paquete `tidyr`


```r
tidyr::gather(mini_iris, key = flower_att, value = measurement,
       Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
```

```
##       Species   flower_att measurement
## 1      setosa Sepal.Length         5.1
## 2  versicolor Sepal.Length         7.0
## 3   virginica Sepal.Length         6.3
## 4      setosa  Sepal.Width         3.5
## 5  versicolor  Sepal.Width         3.2
## 6   virginica  Sepal.Width         3.3
## 7      setosa Petal.Length         1.4
## 8  versicolor Petal.Length         4.7
## 9   virginica Petal.Length         6.0
## 10     setosa  Petal.Width         0.2
## 11 versicolor  Petal.Width         1.4
## 12  virginica  Petal.Width         2.5
```

---

## El paquete `tidyr`


```r
tidyr::gather(mini_iris, key = flower_att, value = measurement, -Species)
```

```
##       Species   flower_att measurement
## 1      setosa Sepal.Length         5.1
## 2  versicolor Sepal.Length         7.0
## 3   virginica Sepal.Length         6.3
## 4      setosa  Sepal.Width         3.5
## 5  versicolor  Sepal.Width         3.2
## 6   virginica  Sepal.Width         3.3
## 7      setosa Petal.Length         1.4
## 8  versicolor Petal.Length         4.7
## 9   virginica Petal.Length         6.0
## 10     setosa  Petal.Width         0.2
## 11 versicolor  Petal.Width         1.4
## 12  virginica  Petal.Width         2.5
```

---

## El paquete `tidyr`

La operación opuesta a `gather()` es `spread()`, que toma los pares _clave-valor_ y los propaga a través de varias columnas. Esto es útil cuando los valores de una columna deberían ser nombres de columnas (es decir, variables). También puede hacer que los datos sean más compactos y más fáciles de leer.

- _data:_ Un data frame
- _key:_ Nombre simple de la columna clave
- _value:_ Nombre simple de los valores en columna 

---

## El paquete `tidyr`


```r
mini_iris_new <- tidyr::gather(mini_iris, key = flower_att, 
                               value = measurement, -Species)
tidyr::spread(mini_iris_new, flower_att, measurement)
```

```
##      Species Petal.Length Petal.Width Sepal.Length Sepal.Width
## 1     setosa          1.4         0.2          5.1         3.5
## 2 versicolor          4.7         1.4          7.0         3.2
## 3  virginica          6.0         2.5          6.3         3.3
```

```r
mini_iris
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1            5.1         3.5          1.4         0.2     setosa
## 51           7.0         3.2          4.7         1.4 versicolor
## 101          6.3         3.3          6.0         2.5  virginica
```

---

## El paquete `tidyr`

La función `separate()`, permite separar una columna en varias. A menos que se le ordene de otra manera, intentará separar en cualquier carácter que no sea una letra o un número. También puede especificar un separador específico mediante el argumento `sep`.

- _data:_ Un data frame
- _col:_ Nombre simple de la columna a separar 
- _into:_ Un vector de caracteres con el nuevo nombre de los valores por columna 

---

## El paquete `tidyr`


```r
set.seed(1)
date <- as.Date('2017-01-01') + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
second <- sample(1:60, 15)
event <- sample(letters, 15)
data_date <- data.frame(date, hour, min, second, event)
head(data_date)
```

```
##         date hour min second event
## 1 2017-01-01    7  30     29     u
## 2 2017-01-02    9  43     36     a
## 3 2017-01-03   13  58     60     l
## 4 2017-01-04   20  22     11     q
## 5 2017-01-05    5  44     47     p
## 6 2017-01-06   18  52     37     k
```

---

## El paquete `tidyr`


```r
data_date_new <- tidyr::separate(data_date, date, 
                                 c("year", "month", "day"))
head(data_date_new)
```

```
##   year month day hour min second event
## 1 2017    01  01    7  30     29     u
## 2 2017    01  02    9  43     36     a
## 3 2017    01  03   13  58     60     l
## 4 2017    01  04   20  22     11     q
## 5 2017    01  05    5  44     47     p
## 6 2017    01  06   18  52     37     k
```

---

## El paquete `tidyr`

La función inversa de `separate()` es `unite()`, que toma varias columnas y las pega juntas. De forma predeterminada, el contenido de las columnas se separará mediante subrayados en la nueva columna, pero este comportamiento se puede modificar mediante el argumento `sep`.

- _data:_ Un data frame
- _col:_ Nombre simple de la nueva columna
- _`...`_ Nombres de las columnas a unir 

---

## El paquete `tidyr`


```r
head(tidyr::unite(data_date_new, time, hour, min, second, sep = ":"))
```

```
##   year month day     time event
## 1 2017    01  01  7:30:29     u
## 2 2017    01  02  9:43:36     a
## 3 2017    01  03 13:58:60     l
## 4 2017    01  04 20:22:11     q
## 5 2017    01  05  5:44:47     p
## 6 2017    01  06 18:52:37     k
```

---

## Síntomas comunes de datos desordenados

- Los encabezados de columna son valores, no nombres de variables

<img class=center src= assets/img/img6.png height=450/>

--- 

## Síntomas comunes de datos desordenados

- Las variables se almacenan en filas y columnas

<img class=center src= assets/img/img7.png height=450/>

--- 

## Síntomas comunes de datos desordenados

- Múltiples variables se almacenan en una columna

<img class=center src= assets/img/img8.png height=450/>

--- 

## Síntomas comunes de datos desordenados

- Una sola unidad de observación se almacena en múltiples tablas
- Múltiples tipos de unidades de observación se almacenan en la misma tabla

<img class=center src= assets/img/img9.png height=450/>

--- 

## Cadenas de caracteres 

Un problema común que aparece cuando se limpian datos es la necesidad de eliminar el espacio en blanco en cadenas de caracteres inicial y/o posterior. La función `str_trim()` del paquete `stringr` hace que sea fácil hacer esto dejando intacta la parte de la cadena que realmente desea.


```r
c("   Filip ", "Nick  ", " Jonathan")
```

```
## [1] "   Filip " "Nick  "    " Jonathan"
```

```r
stringr::str_trim(c("   Filip ", "Nick  ", " Jonathan"))
```

```
## [1] "Filip"    "Nick"     "Jonathan"
```

---

## Cadenas de caracteres 

Un problema similar se presenta cuando se necesita rellenar espacios para hacer de un determinado ancho las cadenas de caracteres.


```r
stringr::str_pad(c("23485W", "8823453Q", "994Z"), width = 9, 
                 side = "left", pad = "0")
```

```
## [1] "00023485W" "08823453Q" "00000994Z"
```

---

## Cadenas de caracteres 

En algunos casos se deben hacer cadenas en mayúsculas o minúsculas, esto es muy sencillo en R (base) gracias a `toupper()` y `tolower()`. Cada función toma exactamente un argumento: la cadena de caracteres (o vector/columna de cadenas) que se convertirá en el caso deseado.


```r
toupper(letters)
```

```
##  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
## [18] "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
```

```r
tolower(LETTERS)
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
## [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
```

---

## Cadenas de caracteres 

El paquete `stringr` proporciona dos funciones que son muy útiles para encontrar y/o reemplazar cadenas: `str_detect()` y `str_replace()`. Como todas las funciones en `stringr`, el primer argumento de cada uno es la cadena de interés. El segundo argumento de cada uno es el patrón de interés.


```r
friends <- c("Sarah", "Tom", "Alice")
stringr::str_detect(friends, "Alice")
```

```
## [1] FALSE FALSE  TRUE
```

```r
stringr::str_replace(friends, "Alice", "David")
```

```
## [1] "Sarah" "Tom"   "David"
```

---

## Fechas 

Las fechas pueden ser un reto para trabajar en cualquier lenguaje de programación, pero gracias al paquete `lubridate`, trabajar con fechas en R no es tan malo.


```r
lubridate::ymd("2015-08-25")
```

```
## [1] "2015-08-25"
```

```r
lubridate::ymd("2015 Agosto 25")
```

```
## [1] "2015-08-25"
```

```r
lubridate::mdy("Agosto 25, 2015")
```

```
## [1] "2015-08-25"
```

---

## Fechas 

Las fechas pueden ser un reto para trabajar en cualquier lenguaje de programación, pero gracias al paquete `lubridate`, trabajar con fechas en R no es tan malo.


```r
lubridate::hms("13:33:09")
```

```
## [1] "13H 33M 9S"
```

```r
lubridate::mdy_hm("Julio 2, 2012 12:56")
```

```
## [1] "2012-07-02 12:56:00 UTC"
```

```r
lubridate::ymd_hms("2015/08/25 13.33.09")
```

```
## [1] "2015-08-25 13:33:09 UTC"
```

---

## Valores faltantes `NA's` 

Los valores faltantes son denotados por `NA` ó `NaN` para indeterminaciones matemáticas 


- `is.na()` es utilizado para probar si existe algún `NA`

- `is.nan()` es utilizado para probar si existe algún `NaN`

- Los `NA` pertenecen a una clase , así, existen enteros `NA`, caracteres `NA`, etc.

- Un valor `NaN` también es `NA` pero lo contrario no es cierto

---

## Valores faltantes `NA's` 


```r
x <- c(1, 2, NA, 10, 3)
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE FALSE
```

```r
is.nan(x)
```

```
## [1] FALSE FALSE FALSE FALSE FALSE
```

---


## Valores faltantes `NA's` 


```r
x <- c(1, 2, NaN, NA, 4)
bad <- is.na(x)
x[!bad]
```

```
## [1] 1 2 4
```

---

## Valores faltantes `NA's` 


```r
x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good
```

```
## [1]  TRUE  TRUE FALSE  TRUE FALSE  TRUE
```

```r
x[good]
```

```
## [1] 1 2 4 5
```

```r
y[good]
```

```
## [1] "a" "b" "d" "f"
```

---

## Valores faltantes `NA's` 


```r
airquality[5:6, ]
```

```
##   Ozone Solar.R Wind Temp Month Day
## 5    NA      NA 14.3   56     5   5
## 6    28      NA 14.9   66     5   6
```

```r
good <- complete.cases(airquality); airquality[good, ][1:6, ]
```

```
##   Ozone Solar.R Wind Temp Month Day
## 1    41     190  7.4   67     5   1
## 2    36     118  8.0   72     5   2
## 3    12     149 12.6   74     5   3
## 4    18     313 11.5   62     5   4
## 7    23     299  8.6   65     5   7
## 8    19      99 13.8   59     5   8
```



