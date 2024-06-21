<cfcomponent output="false">
  <cfset this.name = "RegistoAssiduidade">
  <cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
  <cfset this.sessionManagement = "Yes">
  <cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
  <cfset this.setClientCookies = "Yes">
  <cfprocessingdirective pageencoding="utf-8">
  <cfset this.dsn = "registo_assiduidade"> <!--- testes: ausencias --->

  <cffunction name="onApplicationStart" returnType="boolean" output="false">
    <cfset APPLICATION.dsn = this.dsn>
    <cfreturn true>
  </cffunction>

  <cffunction name="onRequestStart">
    <cfif structKeyExists(URL, "restart") AND URL.restart eq 1>
      <cfset onApplicationStart()>
    </cfif>
  </cffunction>
  
</cfcomponent>


