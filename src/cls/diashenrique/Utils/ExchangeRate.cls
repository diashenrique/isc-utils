Class diashenrique.Utils.ExchangeRate
{

ClassMethod Latest(pAmount As %Integer = 1, pBaseCurrency As %String = "", pListCurrency As %String = "ALL") As %Status
{
    Set tSC = $$$OK 

    Do ..GetRate("Latest",pAmount,,pBaseCurrency, pListCurrency)

    Quit tSC
}

ClassMethod ByDate(pDateSearch As %Date, pAmount As %Integer = 1, pBaseCurrency As %String = "", pListCurrency As %String = "ALL") As %Status
{
    Set tSC = $$$OK 

    Do ..GetRate("ByDate",pAmount,pDateSearch,pBaseCurrency,pListCurrency)

    Quit tSC
}

ClassMethod GetRate(pTypeSearch As %String, pAmount As %Integer = 1, pDateSearch As %Date = "", pBaseCurrency As %String = "", pListCurrency As %String)
{
    Set tSC = $$$OK 

    If (pBaseCurrency = "") {
        Do ..GetDefault(.pBaseCurrency)
    }

    If (pTypeSearch = "ByDate") {
        Set urlExRate = "/api/"_pDateSearch_"?base="_pBaseCurrency
        Set tDateTime = pDateSearch
    }
    Else {
        Set urlExRate = "/api/latest?base="_pBaseCurrency
        Set tDateTime = $ZDate($Horolog,3)
    }

    If (pListCurrency '= "ALL") {
        Set urlExRate = urlExRate_"&symbols="_pListCurrency
    }

    Try {
        Set httprequest = ##class(%Net.HttpRequest).%New()
        Set httprequest.Server = "api.ratesapi.io"
        Set httprequest.Https = 1
        Set httprequest.SSLConfiguration = "SSLUtils"
        Set tSC = httprequest.Get(urlExRate)

        Set stream = httprequest.HttpResponse.Data
        Set json = ##class(%DynamicObject).%FromJSON(stream)

        Write "Date: "_tDateTime,!
        Write "Conversion of "_pAmount_" "_json."base",!!

        Set iter = json."rates".%GetIterator()
        While iter.%GetNext(.key , .value ) {
            Do ..GetCurrency(key,.pCurrencyName)
            Write key_" "_pCurrencyName_" "_$Justify(value * pAmount,30-$Length(pCurrencyName),3),!
        }
    }
    Catch {
        Write httprequest.HttpResponse.StatusCode_" - "_httprequest.HttpResponse.ReasonPhrase,!
        Set tSC = $$$OK
    }
}

ClassMethod GetDefault(ByRef pBaseCurrency)
{
    If $Data(^defaultCurrency(0)) {
        Set pBaseCurrency = $Get(^defaultCurrency(0))
    }
    Else {
        Read "Default Base Currency: ",tDefaultCurrency,!!

        Set ^defaultCurrency(0) = tDefaultCurrency
        Set pBaseCurrency = tDefaultCurrency
    }

    Quit
}

ClassMethod SetDefault(pBaseCurrency As %String) As %Status
{
    Set tSC = $$$OK

    Set ^defaultCurrency(0)=pBaseCurrency

    Quit tSC
}

ClassMethod GetCurrency(pCurrency As %String, ByRef pCurrencyName As %String)
{
    Set tCurrency = ""

    If $Data(^currencies(pCurrency)) {
        Set pCurrencyName = $Get(^currencies(pCurrency))
    }
    Else {
        Do ..SetCurrencies()
        Set pCurrencyName = $Get(^currencies(pCurrency))
    }
}

ClassMethod SetCurrencies()
{
    Set ^currencies("USD")="US dollar"
    Set ^currencies("JPY")="Japanese yen"
    Set ^currencies("BGN")="Bulgarian lev"
    Set ^currencies("CZK")="Czech koruna"
    Set ^currencies("EUR")="Euro"
    Set ^currencies("DKK")="Danish krone"	
    Set ^currencies("GBP")="Pound sterling"		
    Set ^currencies("HUF")="Hungarian forint"
    Set ^currencies("PLN")="Polish zloty"
    Set ^currencies("RON")="Romanian leu"
    Set ^currencies("SEK")="Swedish krona"
    Set ^currencies("CHF")="Swiss franc"
    Set ^currencies("ISK")="Icelandic krona"
    Set ^currencies("NOK")="Norwegian krone"
    Set ^currencies("HRK")="Croatian kuna"
    Set ^currencies("RUB")="Russian rouble"
    Set ^currencies("TRY")="Turkish lira"
    Set ^currencies("AUD")="Australian dollar"
    Set ^currencies("BRL")="Brazilian real"
    Set ^currencies("CAD")="Canadian dollar"
    Set ^currencies("CNY")="Chinese yuan renminbi"
    Set ^currencies("HKD")="Hong Kong dollar"
    Set ^currencies("IDR")="Indonesian rupiah"
    Set ^currencies("ILS")="Israeli shekel"
    Set ^currencies("INR")="Indian rupee"
    Set ^currencies("KRW")="South Korean won"
    Set ^currencies("MXN")="Mexican peso"
    Set ^currencies("MYR")="Malaysian ringgit"
    Set ^currencies("NZD")="New Zealand dollar"
    Set ^currencies("PHP")="Philippine peso"
    Set ^currencies("SGD")="Singapore dollar"
    Set ^currencies("THB")="Thai baht"
    Set ^currencies("ZAR")="South African rand"

    Quit
}

}
