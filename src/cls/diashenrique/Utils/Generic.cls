Class diashenrique.Utils.Generic
{
ClassMethod CreateSSLConfiguration(name As %String)
{
  New $Namespace
  Set $Namespace = "%SYS"

  Do ##class(Security.SSLConfigs).Get(name, .p)

  If $Data(p) quit  

  Set p("CipherList")="ALL:!aNULL:!eNULL:!EXP:!SSLv2"
  Set p("CAFile")=""
  Set p("CAPath")=""
  Set p("CRLFile")=""
  Set p("CertificateFile")=""
  Set p("CipherList")="ALL:!aNULL:!eNULL:!EXP:!SSLv2"
  Set p("Description")=""
  Set p("Enabled")=1
  Set p("PrivateKeyFile")=""
  Set p("PrivateKeyPassword")=""
  Set p("PrivateKeyType")=2
  Set p("Protocols")=24
  Set p("SNIName")=""
  Set p("Type")=0
  Set p("VerifyDepth")=9
  Set p("VerifyPeer")=0

  Do ##class(Security.SSLConfigs).Create(name, .p)
}

}