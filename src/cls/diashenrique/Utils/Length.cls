Class diashenrique.Utils.Length
{

/// Km to Miles conversion 
ClassMethod KmToMiles(pKm As %Double) As %Double
{
    Set tConvert = $Number(pKm / 1.609,2)
    Quit tConvert
}

/// Miles to Km conversion 
ClassMethod MilesToKm(pMiles As %Double) As %Double
{
    Set tConvert = $Number(pMiles * 1.609,2)
    Quit tConvert
}

}
