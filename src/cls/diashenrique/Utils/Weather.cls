Class diashenrique.Utils.Weather
{

ClassMethod GetWeather(pCity As %String = "", pCountry As %String = "", pThermalScale As %String = "") As %Status
{
    Set tSC = $$$OK 

    // Get Default City in case the parameter pCity is empty
    If (pCity = "") {
        Do ..GetDefault(.pCity,,)
    }

    // Get Default Country in case the parameter pCountry is empty
    If (pCountry = "") {
        Do ..GetDefault(,.pCountry,)   
    }

    // Get Default Termo Scale in case the parameter pThermalScale is empty
    If (pThermalScale = "") {
        Do ..GetDefault(,,.pThermalScale)
    }

    Set pThermalScale = $ZConvert(pThermalScale,"U")

    Try {
        Set httprequest = ##class(%Net.HttpRequest).%New()
        Set httprequest.Server = "micro-weather.now.sh"
        Set httprequest.Https = 1
        Set httprequest.SSLConfiguration = "SSLUtils"
        Set tSC = httprequest.Get("/?city="_pCity_"&country="_pCountry)

        Set stream = httprequest.HttpResponse.Data
        Set json = ##class(%DynamicObject).%FromJSON(stream)

        Set tTempNow = json."temp"
        Set tRealFeel = json."feels_like"

        If (pThermalScale = "F") {
            Set tTempNow = ##class(Temperature).CelsiusToFahrenheit(tTempNow)
            Set tRealFeel = ##class(Temperature).CelsiusToFahrenheit(tRealFeel)
        }
        ElseIf (pThermalScale = "K") {
            Set tTempNow = ##class(Temperature).CelsiusToKelvin(tTempNow)
            Set tRealFeel = ##class(Temperature).CelsiusToKelvin(tRealFeel)
        }	

        Write "City: "_pCity_" | Country: "_pCountry,!!
        Write "Temperature: "_tTempNow_" °"_pThermalScale,!
        Write "Real Feel: "_tRealFeel_" °"_pThermalScale,!
        Write "Condition: "_json."condition",!        
    }
    Catch {
        Write httprequest.HttpResponse.StatusCode_" - "_httprequest.HttpResponse.ReasonPhrase,!
        Set tSC = $$$OK
    }

    Quit tSC
}

ClassMethod GetDefault(ByRef pCity, ByRef pCountry, ByRef pThermalScale)
{
    If $Data(^defaultWeather(0)) {
        Set objDefault = $Get(^defaultWeather(0))
        Set pCity = $Piece(objDefault,"^",1)
        Set pCountry = $Piece(objDefault,"^",2)
        Set pThermalScale = $Piece(objDefault,"^",3)
    }
    Else {
        Read "Default City: ",tDefaultCity,!
        Read "Default Country: ",tDefaultCountry,!
        Read "Default Termo Scale(C,F,K): ",tDefaultTermoScale,!!

        Set ^defaultWeather(0) = tDefaultCity_"^"_tDefaultCountry_"^"_tDefaultTermoScale
        Set pCity = tDefaultCity
        Set pCountry = tDefaultCountry
        Set pThermalScale = tDefaultTermoScale
    }

    Quit
}

ClassMethod SetDefault(pCity As %String, pCountry As %String, pThermalScale As %String) As %Status
{
    Set tSC = $$$OK

    Set ^defaultWeather(0)=pCity_"^"_pCountry_"^"_pThermalScale

    Quit tSC
}

}
