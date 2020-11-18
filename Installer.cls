Class App.Installer
{

XData setup
{
<Manifest>
  <Default Name="APPPATH" Dir="/opt/irisapp/" />
  <Default Name="SOURCESPATH" Dir="${APPPATH}src" />
  <Default Name="Namespace" Value="IRISAPP"/>
  <Default Name="app" Value="irisapp" />

  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes" Ensemble="no">
    <Configuration>
      <Database Name="${Namespace}" Dir="/opt/${app}/data" Create="yes" Resource="%DB_${Namespace}"/>
    </Configuration>
    <CSPApplication Url="/csp/${app}" Directory="${cspdir}${app}"  ServeFiles="1" Recurse="1" MatchRoles=":%DB_${Namespace}" AuthenticationMethods="32"/>
    <Import File="${SOURCESPATH}/cls" Recurse="1"/>
  </Namespace>
</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

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
