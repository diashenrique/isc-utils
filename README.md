## ISC-Utils Weather, Exchange Rate, Temperature, Length
The project is a small kit with useful features to help you track weather, exchange rates, conversion for temperature, and length scales.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

Open a terminal and clone/git pull the repo into any local directory

```
$ git clone git@github.com:diashenrique/isc-utils.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

## How to Run the Application

Open InterSystems IRIS terminal:


### Temperature Scale Conversion
```
$ docker-compose exec iris iris session iris
USER>zn "IRISAPP"

IRISAPP>write ##class(diashenrique.Utils.Temperature).CelsiusToFahrenheit(28)
82.4

IRISAPP>write ##class(diashenrique.Utils.Temperature).CelsiusToKelvin(28)
301.15

IRISAPP>write ##class(diashenrique.Utils.Temperature).FahrenheitToCelsius(82.4)
28

IRISAPP>write ##class(diashenrique.Utils.Temperature).FahrenheitToKelvin(82.4)
301.15

IRISAPP>write ##class(diashenrique.Utils.Temperature).KelvinToCelsius(301.15)
28

IRISAPP>write ##class(diashenrique.Utils.Temperature).KelvinToFahrenheit(301.15)
82.37
```

### Length Scale Conversion

```
IRISAPP>write ##class(diashenrique.Utils.Length).KmToMiles(120)
74.58

IRISAPP>write ##class(diashenrique.Utils.Length).MilesToKm(74.58)
120
```

### Exchange Rate

#### Latest
```
IRISAPP>do ##class(diashenrique.Utils.ExchangeRate).Latest(1,"USD","ALL")
Date: 2020-03-18
Conversion of 1 USD

GBP Pound sterling            0.843
HKD Hong Kong dollar          7.766
IDR Indonesian rupiah     15449.552
ILS Israeli shekel            3.810
DKK Danish krone              6.835
INR Indian rupee             74.205
CHF Swiss franc               0.965
MXN Mexican peso             23.963
CZK Czech koruna             24.834
SGD Singapore dollar          1.441
THB Thai baht                32.420
HRK Croatian kuna             6.945
EUR Euro                      0.915
MYR Malaysian ringgit         4.371
NOK Norwegian krone          10.701
CNY Chinese yuan renminbi     7.035
BGN Bulgarian lev             1.789
PHP Philippine peso          51.620
PLN Polish zloty              4.117
ZAR South African rand       16.977
CAD Canadian dollar           1.440
ISK Icelandic krona         139.656
BRL Brazilian real            5.134
RON Romanian leu              4.431
NZD New Zealand dollar        1.713
TRY Turkish lira              6.447
JPY Japanese yen            107.719
RUB Russian rouble           79.656
KRW South Korean won       1260.106
USD US dollar                 1.000
AUD Australian dollar         1.698
HUF Hungarian forint        321.365
SEK Swedish krona            10.081
```
Parameters:
* Amount
* Base Currency Eg. JPY
* Exchange rates
  * ALL - for all currencies availables in the API
  * Request specific exchange rates. Eg.: "BRL,AUD,CAD,RUB"

#### ByDate

```
IRISAPP>do ##class(diashenrique.Utils.ExchangeRate).ByDate("2020-01-01",1,"USD","BRL,JPY,AUD,CAD")
Date: 2020-01-01
Conversion of 1 USD

JPY Japanese yen            108.545
AUD Australian dollar         1.424
CAD Canadian dollar           1.299
BRL Brazilian real            4.020
```
Parameters:
* Date = YYYY-MM-DD
* Amount
* Base Currency Eg. BRL
* Exchange rates
  * ALL - for all currencies availables in the API
  * Request specific exchange rates Eg. "BRL,AUD,CAD,RUB"
  
There is a global ^defaultCurrency, that'll keep your preferred base currency. 

So, you can call the ClassMethod Latest, without any parameter:
```
IRISAPP>do ##class(diashenrique.Utils.ExchangeRate).Latest()
Default Base Currency: 
```

Just inform your preferred base currency: 
```
IRISAPP>do ##class(diashenrique.Utils.ExchangeRate).Latest()
Default Base Currency: USD

Date: 2020-03-18
Conversion of 1 USD

GBP Pound sterling            0.843
HKD Hong Kong dollar          7.766
IDR Indonesian rupiah     15449.552
ILS Israeli shekel            3.810
DKK Danish krone              6.835
INR Indian rupee             74.205
CHF Swiss franc               0.965
MXN Mexican peso             23.963
CZK Czech koruna             24.834
SGD Singapore dollar          1.441
THB Thai baht                32.420
HRK Croatian kuna             6.945
EUR Euro                      0.915
MYR Malaysian ringgit         4.371
NOK Norwegian krone          10.701
CNY Chinese yuan renminbi     7.035
BGN Bulgarian lev             1.789
PHP Philippine peso          51.620
PLN Polish zloty              4.117
ZAR South African rand       16.977
CAD Canadian dollar           1.440
ISK Icelandic krona         139.656
BRL Brazilian real            5.134
RON Romanian leu              4.431
NZD New Zealand dollar        1.713
TRY Turkish lira              6.447
JPY Japanese yen            107.719
RUB Russian rouble           79.656
KRW South Korean won       1260.106
USD US dollar                 1.000
AUD Australian dollar         1.698
HUF Hungarian forint        321.365
SEK Swedish krona            10.081
```
### Weather

```
IRISAPP>do ##class(diashenrique.Utils.Weather).GetWeather()
Default City: 
Default Country: 
Default Termo Scale(C,F,K): 
```
The ClassMethod GetWeather, also has preferred options. For Default possibilities we have: 
* City
* Country
* Thermal Scale (Celsius, Fahrenheit or Kelvin)

```
IRISAPP>do ##class(diashenrique.Utils.Weather).GetWeather()
Default City: Boston
Default Country: USA
Default Termo Scale(C,F,K): F

City: Boston | Country: USA

Temperature: 53.46 °F
Real Feel: 46.02 °F
Condition: Clear
```

But, you can consult any other city sending the parameters:
```
IRISAPP>do ##class(diashenrique.Utils.Weather).GetWeather("Sao Paulo","Brazil","C")
City: Sao Paulo | Country: Brazil

Temperature: 27.55 °C
Real Feel: 28.4 °C
Condition: Rain
```

After defining the default parameters, they become optional:
```
IRISAPP>do ##class(diashenrique.Utils.Weather).GetWeather("Sao Paulo","Brazil")
City: Sao Paulo | Country: Brazil

Temperature: 82.17 °F
Real Feel: 83.95 °F
Condition: Rain
```
