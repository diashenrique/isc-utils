Class diashenrique.Utils.Temperature
{

/// Fahrenheit to Celsius conversion (°F to °C)
ClassMethod FahrenheitToCelsius(pTemperature As %Double) As %Double
{
    Set tConvert = $Number((pTemperature - 32) / 1.8,2)
    Quit tConvert
}

/// Fahrenheit to Kelvin conversion (°F to °K)
ClassMethod FahrenheitToKelvin(pTemperature As %Double) As %Double
{
    Set tCelsius = ..FahrenheitToCelsius(pTemperature)
    Set tConvert = ..CelsiusToKelvin(tCelsius)
    Quit tConvert
}

/// Celsius to Fahrenheit conversion (°C to °F)
ClassMethod CelsiusToFahrenheit(pTemperature As %Double) As %Double
{
    Set tConvert = $Number((pTemperature * 1.8) + 32,2)
    Quit tConvert
}

/// Celsius to Kelvin conversion (°C to °K)
ClassMethod CelsiusToKelvin(pTemperature As %Double) As %Double
{
    Set tConvert = $Number(pTemperature + 273.15,2)
    Quit tConvert
}

/// Kelvin to Celsius conversion (°K to °C)
ClassMethod KelvinToCelsius(pTemperature As %Double) As %Double
{
    Set tConvert = $Number(pTemperature - 273.15,2)
    Quit tConvert
}

/// Kelvin to Fahrenheit conversion (°K to °F)
ClassMethod KelvinToFahrenheit(pTemperature As %Double) As %Double
{
    Set tConvert = $Number((pTemperature * 1.8) - 459.7,2)
    Quit tConvert
}

}
