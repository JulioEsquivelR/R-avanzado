---
title       : R avanzado  
subtitle    : Manipulación de datos 
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

## El paquete `dplyr`

El paquete `dplyr` hace parte del llamado [`tidyverso`](http://tidyverse.org). El _**tidyverse**_ es una colección de paquetes R que comparten filosofías comunes y están diseñados para trabajar juntos. 

<img class=center src= assets/img/img1.png height=450 weight=800 />

---

## El paquete `dplyr`

La filosofía del paquete `dplyr` es la implementación de _**grammar of
data manipulation**_ o la gramática de la manipulación de datos. 

- Encontrar patrones latentes en los datos
    + Nuevas variables 
    + Estadísticas de resumen 
    + diferencias entre grupos 
- Cinco funciones que reducen el trabajo 
- Es rápido, las funciones principales están escritas en `c++`
- Una nueva estructura `tbl` y el operador `%>%`
- Inclusive permite trabajar con _Bases de datos_

---

## `tbl` una nueva estructura 

El formato `tbl` es sólo un tipo especial de _data frame_ que hace que los datos sean más fáciles de visualizar, pero también más fáciles de trabajar. El formato `tbl` cambia la forma cómo R muestra sus datos, pero no cambia la estructura de datos subyacente de los datos. 


```r
suppressMessages(suppressWarnings(library(dplyr)))
suppressMessages(suppressWarnings(library(hflights)))
hflights <- tbl_df(hflights)
hflights
```

---

## `tbl` una nueva estructura 


```r
suppressMessages(suppressWarnings(library(hflights)))
hflights <- dplyr::tbl_df(hflights); head(hflights, 4)
```

```
## # A tibble: 4 x 21
##    Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
##   <int> <int>      <int>     <int>   <int>   <int>         <chr>     <int>
## 1  2011     1          1         6    1400    1500            AA       428
## 2  2011     1          2         7    1401    1501            AA       428
## 3  2011     1          3         1    1352    1502            AA       428
## 4  2011     1          4         2    1403    1513            AA       428
## # ... with 13 more variables: TailNum <chr>, ActualElapsedTime <int>,
## #   AirTime <int>, ArrDelay <int>, DepDelay <int>, Origin <chr>,
## #   Dest <chr>, Distance <int>, TaxiIn <int>, TaxiOut <int>,
## #   Cancelled <int>, CancellationCode <chr>, Diverted <int>
```

---

## Las cinco funciones (Verbos)

El paquete `dplyr` contiene cinco funciones clave de manipulación de datos, también llamadas verbos:

- `select()`, que devuelve un subconjunto de las columnas,
- `filter()`, que es capaz de devolver un subconjunto de las filas,
- `arrange()`, que reordena las filas de acuerdo a variables individuales o múltiples,
- `mutate()`, es utilizado para agregar columnas de datos existentes,
- `summarise()`, que reduce cada grupo a una sola fila calculando funciones de agregación.

---

## Las cinco funciones (Verbos)


<img align="left" src= assets/img/img2.png height=450  />
<img align="right" src= assets/img/img3.png height=450  />

---

## `select`


```r
head(dplyr::select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay))
```

```
## # A tibble: 6 x 4
##   ActualElapsedTime AirTime ArrDelay DepDelay
##               <int>   <int>    <int>    <int>
## 1                60      40      -10        0
## 2                60      45       -9        1
## 3                70      48       -8       -8
## 4                70      39        3        3
## 5                62      44       -3        5
## 6                64      45       -7       -1
```

---

## `select`


```r
# Se puede urilizar el operador ":" para seleccionar un rango de variables 
head(dplyr::select(hflights, Origin:Cancelled))
```

```
## # A tibble: 6 x 6
##   Origin  Dest Distance TaxiIn TaxiOut Cancelled
##    <chr> <chr>    <int>  <int>   <int>     <int>
## 1    IAH   DFW      224      7      13         0
## 2    IAH   DFW      224      6       9         0
## 3    IAH   DFW      224      5      17         0
## 4    IAH   DFW      224      9      22         0
## 5    IAH   DFW      224      9       9         0
## 6    IAH   DFW      224      6      13         0
```

---

## `select`


```r
# Para excluir algunas variables se utiliza el operador "-"
head(dplyr::select(hflights, -c(DepTime:AirTime)))
```

```
## # A tibble: 6 x 14
##    Year Month DayofMonth DayOfWeek ArrDelay DepDelay Origin  Dest Distance
##   <int> <int>      <int>     <int>    <int>    <int>  <chr> <chr>    <int>
## 1  2011     1          1         6      -10        0    IAH   DFW      224
## 2  2011     1          2         7       -9        1    IAH   DFW      224
## 3  2011     1          3         1       -8       -8    IAH   DFW      224
## 4  2011     1          4         2        3        3    IAH   DFW      224
## 5  2011     1          5         3       -3        5    IAH   DFW      224
## 6  2011     1          6         4       -7       -1    IAH   DFW      224
## # ... with 5 more variables: TaxiIn <int>, TaxiOut <int>, Cancelled <int>,
## #   CancellationCode <chr>, Diverted <int>
```

---

## `select` - funciones auxiliares 

`dplyr` viene con un conjunto de funciones auxiliares que pueden ayudar a seleccionar grupos de variables dentro de una llamada a la función `select()`:

- `starts_with("X")`: cada nombre que empiece por "X",
- `ends_with("X")`: cada nombre que termina con "X",
- `contains("X")`: cada nombre que contiene "X",
- `matches("X")`: cada nombre que coincide con "X", donde "X" puede ser una expresión regular,
- `num_range("x", 1:5)`: las variables denominadas x01, x02, x03, x04 y x05,
- `one_of(x)`: cada nombre que aparece en x, que debería ser un vector de caracteres.

---

## `select` - funciones auxiliares 


```r
head(dplyr::select(hflights, dplyr::ends_with("Delay")))
```

```
## # A tibble: 6 x 2
##   ArrDelay DepDelay
##      <int>    <int>
## 1      -10        0
## 2       -9        1
## 3       -8       -8
## 4        3        3
## 5       -3        5
## 6       -7       -1
```

---

## `select` - funciones auxiliares 


```r
head(dplyr::select(hflights, dplyr::contains("Ca"), dplyr::ends_with("Num")))
```

```
## # A tibble: 6 x 5
##   UniqueCarrier Cancelled CancellationCode FlightNum TailNum
##           <chr>     <int>            <chr>     <int>   <chr>
## 1            AA         0                        428  N576AA
## 2            AA         0                        428  N557AA
## 3            AA         0                        428  N541AA
## 4            AA         0                        428  N403AA
## 5            AA         0                        428  N492AA
## 6            AA         0                        428  N262AA
```

---

## `select` - funciones auxiliares 


```r
head(dplyr::select(hflights, dplyr::ends_with("Time"),
                   dplyr::ends_with("Delay")))
```

```
## # A tibble: 6 x 6
##   DepTime ArrTime ActualElapsedTime AirTime ArrDelay DepDelay
##     <int>   <int>             <int>   <int>    <int>    <int>
## 1    1400    1500                60      40      -10        0
## 2    1401    1501                60      45       -9        1
## 3    1352    1502                70      48       -8       -8
## 4    1403    1513                70      39        3        3
## 5    1405    1507                62      44       -3        5
## 6    1359    1503                64      45       -7       -1
```

---

## `mutate`

`mutate()` es la segunda de cinco funciones de manipulación de datos. `mutate()` crea nuevas columnas que se agregan a una copia del conjunto de datos.


```r
g1 <- dplyr::mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime)
head(dplyr::select(g1, dplyr::ends_with("Time")))
```

```
## # A tibble: 6 x 5
##   DepTime ArrTime ActualElapsedTime AirTime ActualGroundTime
##     <int>   <int>             <int>   <int>            <int>
## 1    1400    1500                60      40               20
## 2    1401    1501                60      45               15
## 3    1352    1502                70      48               22
## 4    1403    1513                70      39               31
## 5    1405    1507                62      44               18
## 6    1359    1503                64      45               19
```

---

## `mutate`


```r
g2 <- dplyr::mutate(g1, GroundTime = TaxiIn + TaxiOut)
head(dplyr::select(g2, dplyr::starts_with("Ground"), dplyr::contains("Taxi")))
```

```
## # A tibble: 6 x 3
##   GroundTime TaxiIn TaxiOut
##        <int>  <int>   <int>
## 1         20      7      13
## 2         15      6       9
## 3         22      5      17
## 4         31      9      22
## 5         18      9       9
## 6         19      6      13
```

---

## `mutate`


```r
g3 <- dplyr::mutate(g2, AverageSpeed = Distance / AirTime * 60)
head(dplyr::select(g3, AverageSpeed, Distance, AirTime))
```

```
## # A tibble: 6 x 3
##   AverageSpeed Distance AirTime
##          <dbl>    <int>   <int>
## 1     336.0000      224      40
## 2     298.6667      224      45
## 3     280.0000      224      48
## 4     344.6154      224      39
## 5     305.4545      224      44
## 6     298.6667      224      45
```

---

## `mutate`


```r
m2 <- dplyr::mutate(hflights, TotalTaxi = TaxiIn+TaxiOut, 
                    ActualGroundTime = ActualElapsedTime-AirTime, 
                    Diff = TotalTaxi-ActualGroundTime)
head(dplyr::select(m2, TotalTaxi, ActualGroundTime, Diff))
```

```
## # A tibble: 6 x 3
##   TotalTaxi ActualGroundTime  Diff
##       <int>            <int> <int>
## 1        20               20     0
## 2        15               15     0
## 3        22               22     0
## 4        31               31     0
## 5        18               18     0
## 6        19               19     0
```

---

## `filter`

`mutate()` es la segunda de cinco funciones de manipulación de datos. `filter()` es capaz de devolver un subconjunto de las filas del conjunto de datos que cumplan con una condición.


```r
f1 <- dplyr::filter(hflights, Distance >= 3000 )
head(dplyr::select(f1, dplyr::starts_with("D")))
```

```
## # A tibble: 6 x 7
##   DayofMonth DayOfWeek DepTime DepDelay  Dest Distance Diverted
##        <int>     <int>   <int>    <int> <chr>    <int>    <int>
## 1         31         1     924       -1   HNL     3904        0
## 2         30         7     925        0   HNL     3904        0
## 3         29         6    1045       80   HNL     3904        0
## 4         28         5    1516      351   HNL     3904        0
## 5         27         4     950       25   HNL     3904        0
## 6         26         3     944       19   HNL     3904        0
```

---

## `filter`


```r
f2 <- dplyr::filter(hflights, TaxiIn + TaxiOut > AirTime)
head(dplyr::select(f2,TaxiIn, TaxiOut, AirTime))
```

```
## # A tibble: 6 x 3
##   TaxiIn TaxiOut AirTime
##    <int>   <int>   <int>
## 1     14      37      42
## 2     10      40      43
## 3     10      35      43
## 4     27      20      45
## 5      5      23      27
## 6      7      25      30
```

---

## `filter`


```r
f3 <- dplyr::filter(hflights, DepTime < 500 | ArrTime > 2200)
head(dplyr::select(f3, dplyr::contains("Time")))
```

```
## # A tibble: 6 x 4
##   DepTime ArrTime ActualElapsedTime AirTime
##     <int>   <int>             <int>   <int>
## 1    2100    2207                67      42
## 2    2119    2229                70      45
## 3    1934    2235               121     107
## 4    1905    2211               126     111
## 5    1856    2209               133     108
## 6    1938    2228               290     253
```

---

## `filter`


```r
f4 <- dplyr::filter(hflights, DepDelay > 0 , ArrDelay < 0)
head(dplyr::select(f4, dplyr::contains("Delay")))
```

```
## # A tibble: 6 x 2
##   ArrDelay DepDelay
##      <int>    <int>
## 1       -9        1
## 2       -3        5
## 3       -2        8
## 4       -8        1
## 5       -7       10
## 6       -4       15
```

---

## `arrange`

`arrange()`se puede utilizar para reorganizar filas de acuerdo a cualquier tipo de datos. Si pasa a `arrange()` una variable tipo caracter, R reorganizará las filas en orden alfabético según los valores de la variable. Si pasa una variable de factor, R reorganizará las filas de acuerdo con el orden de los niveles en su factor.


```r
dtc <- dplyr::filter(hflights, Cancelled == 1, !is.na(DepDelay))
dtc1 <- dplyr::select(dtc, Cancelled, DepDelay, CancellationCode,
                      UniqueCarrier) 
head(dplyr::arrange(dtc1, DepDelay), 3)
```

```
## # A tibble: 3 x 4
##   Cancelled DepDelay CancellationCode UniqueCarrier
##       <int>    <int>            <chr>         <chr>
## 1         1      -10                A            F9
## 2         1       -9                B            XE
## 3         1       -9                A            US
```

---

## `arrange`


```r
head(dplyr::arrange(dtc1, CancellationCode))
```

```
## # A tibble: 6 x 4
##   Cancelled DepDelay CancellationCode UniqueCarrier
##       <int>    <int>            <chr>         <chr>
## 1         1       -4                A            UA
## 2         1       73                A            XE
## 3         1        8                A            AA
## 4         1      187                A            CO
## 5         1       28                A            OO
## 6         1       -3                A            OO
```

---

## `arrange`


```r
head(dplyr::arrange(dtc1, UniqueCarrier, DepDelay))
```

```
## # A tibble: 6 x 4
##   Cancelled DepDelay CancellationCode UniqueCarrier
##       <int>    <int>            <chr>         <chr>
## 1         1        3                A            AA
## 2         1        8                A            AA
## 3         1       -6                A            CO
## 4         1        0                B            CO
## 5         1        0                A            CO
## 6         1       24                C            CO
```

---

## `summarise`

`summarise()` el último de los 5 verbos, sigue la misma sintaxis que `mutate()`, pero el conjunto de datos resultante consta de una sola fila, en contraste con las otras cuatro funciones de manipulación de datos, `summarise()` no devuelve una copia alterada del conjunto de datos que está resumiendo; en su lugar, crea un nuevo conjunto de datos que contiene sólo las estadísticas de resumen.


```r
temp1 <- dplyr::filter(hflights, !is.na(ArrDelay))
dplyr::summarise(temp1, earliest = min(ArrDelay), 
                 average = mean(ArrDelay), 
                 latest = max(ArrDelay), sd = sd(ArrDelay))
```

```
## # A tibble: 1 x 4
##   earliest  average latest       sd
##      <dbl>    <dbl>  <dbl>    <dbl>
## 1      -70 7.094334    978 30.70852
```

---

## `summarise` - funciones de resumen

`dplyr` proporciona varias funciones de resumen propias, además de las que ya están definidas en R. Estas incluyen:

- `first(x)`: El primer elemento del vector x.
- `last(x)`: El último elemento del vector x.
- `nth(x, n)`: El n-ésimo elemento del vector x.
- `n()`: El número de filas en el _data frame_ o grupo de observaciones que `summarise()` describe.
- `n_distinct(x)`: El número de valores únicos en el vector x.

---

## `summarise` - funciones de resumen


```r
dplyr::summarise(hflights,
                 n_obs = n(),
                 n_carrier = n_distinct(UniqueCarrier),
                 n_dest = n_distinct(Dest))
```

```
## # A tibble: 1 x 3
##    n_obs n_carrier n_dest
##    <int>     <int>  <int>
## 1 227496        15    116
```

---

## El operador `pipe %>%`

<br>
<br>
<br>

<img class=center src= assets/img/img4.png height=450  />

---

## El operador `pipe %>%`

<br>
<br>
<br>

<img class=center src= assets/img/img5.png height=450  />

---

## El operador `pipe %>%`

<br>
<br>
<br>


<img class=center src= assets/img/img6.png height=450  />

---

## El operador `pipe %>%`

<br>
<br>
<br>


<img class=center src= assets/img/img7.png height=450  />

---

## El operador `pipe %>%`

<br>
<br>
<br>


<img class=center src= assets/img/img8.png height=450  />

---

## El operador `pipe %>%`


<img class=center src= assets/img/img9.png height=450  />

---

## El operador `pipe %>%`


```r
suppressMessages(suppressWarnings(library(dplyr)))

hflights %>%  
    mutate( diff = TaxiOut - TaxiIn) %>% 
    filter( !is.na(diff) ) %>% 
    summarise( avg = mean(diff))
```

```
## # A tibble: 1 x 1
##        avg
##      <dbl>
## 1 8.992064
```

---

## El operador `pipe %>%`


```r
hflights %>% 
    mutate( RealTime = ActualElapsedTime + 100, 
            mph = Distance/RealTime * 60) %>% 
    filter(!is.na(mph) & mph < 70) %>% 
    summarise( n_less = n(), n_dest = n_distinct(Dest), 
               min_dist = min(Distance), max_dist = max(Distance))
```

```
## # A tibble: 1 x 4
##   n_less n_dest min_dist max_dist
##    <int>  <int>    <dbl>    <dbl>
## 1   6726     13       79      305
```

---

## `group_by`

`group_by()` permite definir grupos dentro de su conjunto de datos. Su influencia se hace clara al llamar a `summarise()` en un conjunto de datos agrupado: las estadísticas de resumen se calculan por separado para los diferentes grupos.

---

## `group_by`


```r
hflights %>% 
    group_by(UniqueCarrier) %>% 
    summarise(p_canc = mean(Cancelled == 1)*100, 
              avg_delay = mean(ArrDelay, na.rm = T)) %>%
    arrange((avg_delay), p_canc) %>% head 
```

```
## # A tibble: 6 x 3
##   UniqueCarrier    p_canc  avg_delay
##           <chr>     <dbl>      <dbl>
## 1            US 1.1268986 -0.6307692
## 2            AA 1.8495684  0.8917558
## 3            FL 0.9817672  1.8536239
## 4            AS 0.0000000  3.1923077
## 5            YV 1.2658228  4.0128205
## 6            DL 1.5903067  6.0841374
```

---

## `group_by`


```r
hflights %>% 
    filter( !is.na(ArrDelay), ArrDelay > 0) %>% group_by(UniqueCarrier) %>%
    summarise(avg = mean(ArrDelay)) %>% mutate(rank = rank(avg)) %>%
    arrange(rank) %>% head 
```

```
## # A tibble: 6 x 3
##   UniqueCarrier      avg  rank
##           <chr>    <dbl> <dbl>
## 1            YV 18.67568     1
## 2            F9 18.68683     2
## 3            US 20.70235     3
## 4            CO 22.13374     4
## 5            AS 22.91195     5
## 6            OO 24.14663     6
```

---

## `dplyr` en bases de datos 

<br>

<img class=center src= assets/img/img10.png height=450  />

---

## `dplyr` en bases de datos 


```r
# suppressMessages(suppressWarnings(library(dplyr)))
# suppressMessages(suppressWarnings(library(dbplyr)))
# my_db <- src_mysql(dbname = "dplyr", 
#                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
#                   port = 3306, 
#                   user = "student",
#                   password = "datacamp")
```

---

## `dplyr` en bases de datos 


```r
# nycflights <- tbl(my_db, "dplyr")
# glimpse(nycflights)
```

---

## funciones `join` en `dplyr`

- _**Mutating joins**_

- _**Filtering joins y operaciones sobre conjuntos**_

- _**Ensamble de datos**_

- _**Joins avanzados**_

---

## funciones `join` en `dplyr`

Originalmente  las funciones `join` en `R` se realizan como vimos anteriormente con la función `merge()`, pero la elaboración de esta tarea con `dplyr` ofrece ciertas ventajas: 

- Se preserva el orden de las filas 

- Sintaxis intuitiva 

- Se puede aplicar a _bases de datos_, _spark_, etc.

---

## llaves - primaria y foranea 


<img class=center src= assets/img/img11.png height=450  />

---

## llaves - primaria y foranea 


<img class=center src= assets/img/img12.png height=450  />

---

## `mutate()`

<img class=center src= assets/img/img13.png height=450  />

---

## `left_join()`

`left_join()` es la función de unión más básica en `dplyr`. Se puede utilizar siempre que desee aumentar un _data frame_ con información de otro _data frame_.

<br>
<br>

<img class=center src= assets/img/img14.png height=450  />

---


## `left_join()`


```r
left_join(band_members, band_instruments, by = "name")
```

```
## # A tibble: 3 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  Mick  Stones   <NA>
## 2  John Beatles guitar
## 3  Paul Beatles   bass
```

---

## `left_join()`


```r
band_members %>% 
    left_join(band_instruments)
```

```
## # A tibble: 3 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  Mick  Stones   <NA>
## 2  John Beatles guitar
## 3  Paul Beatles   bass
```

---

## `right_join()`

`right_join()` realiza la misma tarea que `left_join()`, se puede utilizar siempre que desee aumentar un _data frame_ con información de otro _data frame_, pero esta prioriza los datos en la tabla de la derecha de la unión.

<br>
<br>

<img class=center src= assets/img/img15.png height=450  />

---


## `right_join()`


```r
right_join(band_members, band_instruments, by = "name")
```

```
## # A tibble: 3 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  John Beatles guitar
## 2  Paul Beatles   bass
## 3 Keith    <NA> guitar
```

---

## `right_join()`


```r
band_members %>% 
    right_join(band_instruments)
```

```
## # A tibble: 3 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  John Beatles guitar
## 2  Paul Beatles   bass
## 3 Keith    <NA> guitar
```

---

## `inner_join()` - `full_join()`

funciones complementarias a las anteriores se basan en el mismo concepto de agregar datos a un _data frame_, en este caso `inner_join()` devuelve solo lo que esta en ambos _data frame_ y contraste `full_join()` devuelve toda la información disponible en ambos _data frame_.

<br>

<img class=center src= assets/img/img16.png height=450  />

---

## `inner_join()`


```r
inner_join(band_members, band_instruments, by = "name")
```

```
## # A tibble: 2 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  John Beatles guitar
## 2  Paul Beatles   bass
```

---

## `inner_join()`


```r
band_members %>% 
    inner_join(band_instruments)
```

```
## # A tibble: 2 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  John Beatles guitar
## 2  Paul Beatles   bass
```

---

## `full_join()`


```r
full_join(band_members, band_instruments, by = "name")
```

```
## # A tibble: 4 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  Mick  Stones   <NA>
## 2  John Beatles guitar
## 3  Paul Beatles   bass
## 4 Keith    <NA> guitar
```

---

## `full_join()`


```r
band_members %>% 
    full_join(band_instruments)
```

```
## # A tibble: 4 x 3
##    name    band  plays
##   <chr>   <chr>  <chr>
## 1  Mick  Stones   <NA>
## 2  John Beatles guitar
## 3  Paul Beatles   bass
## 4 Keith    <NA> guitar
```

---

## `filter()`

<br>

<img class=center src= assets/img/img17.png height=450  />

---

## Filtering joins

<br>
<br>

<img class=center src= assets/img/img18.png height=450  />

---

## `semi_join()`

Los `semi_join` proporcionan una manera concisa de filtrar datos del primer conjunto de datos basado en la información de un segundo conjunto de datos.


```r
semi_join(band_members, band_instruments, by = "name")
```

```
## # A tibble: 2 x 2
##    name    band
##   <chr>   <chr>
## 1  John Beatles
## 2  Paul Beatles
```

---

## `semi_join()`


```r
band_members %>% 
    semi_join(band_instruments)
```

```
## Joining, by = "name"
```

```
## # A tibble: 2 x 2
##    name    band
##   <chr>   <chr>
## 1  John Beatles
## 2  Paul Beatles
```

--- 

## `anti_join()`

Se utiliza un `anti-join` para ver qué filas no se emparejan con un segundo conjunto de datos mediante una combinación.


```r
anti_join(band_members, band_instruments, by = "name")
```

```
## # A tibble: 1 x 2
##    name   band
##   <chr>  <chr>
## 1  Mick Stones
```

---

## `anti_join()`


```r
band_members %>% 
    anti_join(band_instruments)
```

```
## Joining, by = "name"
```

```
## # A tibble: 1 x 2
##    name   band
##   <chr>  <chr>
## 1  Mick Stones
```

---

## Operaciones sobre conjuntos 

<img class=center src= assets/img/img19.png height=450  />

---

## Unión 


```r
aerosmith <- readr::read_csv("data/aerosmith.csv")
greatest_hits <- readr::read_csv("data/greatest_hits.csv")
live <- readr::read_csv("data/live.csv")


aerosmith %>% 
    dplyr::union(greatest_hits) %>% 
    nrow()
```

```
## [1] 24
```

---


## Intersección 


```r
aerosmith %>% 
  dplyr::intersect(greatest_hits)
```

```
## # A tibble: 1 x 2
##       song   length
##      <chr>   <time>
## 1 Dream On 04:28:00
```

---

## `setdiff()`


```r
live_songs <- live %>%  select(song)
greatest_songs <- greatest_hits %>% select(song)
live_songs %>% 
  setdiff(greatest_songs) %>%
    head()
```

```
## # A tibble: 6 x 1
##                 song
##                <chr>
## 1 Back in the Saddle
## 2      Sweet Emotion
## 3 Lord of the Thighs
## 4  Toys in the Attic
## 5         Last Child
## 6      Come Together
```

---

## `setequal()`


```r
first <- mtcars[1:20, ]
second <- mtcars[10:32, ]

dplyr::setequal(mtcars, mtcars[32:1, ])
```

```
## TRUE
```

---

## `Binds` 

<img class=center src= assets/img/img20.png height=450  />

---

## Beneficios 

- Rápida 

- Devuelve un objeto `tibble`

- Trabaja con _data frame_ y _listas_

- `.id`

---

## `bind_rows()`


```r
side_one <- readr::read_csv("data/side_one.csv")
side_two <- readr::read_csv("data/side_two.csv")
side_one %>% 
  bind_rows(side_two) %>%
    head()
```

```
## # A tibble: 6 x 2
##                       song   length
##                      <chr>   <time>
## 1              Speak to Me 01:30:00
## 2                  Breathe 02:43:00
## 3               On the Run 03:30:00
## 4                     Time 06:53:00
## 5 The Great Gig in the Sky 04:15:00
## 6                    Money 06:30:00
```

---

## `bind_cols()`


```r
hank_years <- readr::read_csv("data/hank_years.csv")
hank_charts <- readr::read_csv("data/hank_charts.csv")
hank_years %>% 
  arrange(song) %>% 
  select(year) %>% 
  bind_cols(hank_charts) %>% 
  arrange(year, song) %>%
    head(3)
```

```
## # A tibble: 3 x 3
##    year                                    song  peak
##   <int>                                   <chr> <int>
## 1  1947                         Move It On Over     4
## 2  1947    My Love for You (Has Turned to Hate)    NA
## 3  1947 Never Again (Will I Knock on Your Door)    NA
```

---

## Reglas de coerción 

<img class=center src= assets/img/img21.png height=450  />

---

## Unión de varias tablas 

<img class=center src= assets/img/img22.png height=450  />

---

## Unión de varias tablas 


```r
suppressMessages(suppressWarnings(library(purrr)))

list(band_members, band_instruments, band_instruments2) %>% 
  reduce(left_join)
```

```
## # A tibble: 4 x 4
##    name    band  plays artist
##   <chr>   <chr>  <chr>  <chr>
## 1  Mick  Stones   <NA>   <NA>
## 2  John Beatles guitar   John
## 3  John Beatles guitar  Keith
## 4  Paul Beatles   bass   Paul
```

