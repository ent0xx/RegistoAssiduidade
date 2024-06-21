<cfcomponent>

  <cfset variables.tipoAusencia = "">
  <cfset variables.dataInicio = "">
  <cfset variables.dataFim = "">
  <cfset variables.razao = "">
  <cfset variables.arquivo = "">
  <cfset variables.FID_funcionario = Session.MM_UserID>

  <cffunction name="init" access="public" returntype="any" output="false">
    <cfargument name="tipoAusencia" type="numeric">
    <cfargument name="dataInicio" type="date">
    <cfargument name="dataFim" type="date">
    <cfargument name="razao" type="string">
    <!--- <cfargument name="arquivo" type="any">  --->
    <cfargument name="FID_funcionario" type="string"> 

    <cfset setTipoAusencia(arguments.tipoAusencia)>
    <cfset setDataInicio(arguments.dataInicio)>
    <cfset setDataFim(arguments.dataFim)>
    <cfset setRazao(arguments.razao)>
   <!---  <cfset setArquivo(arguments.arquivo)> --->
    <cfset setFID_funcionario(arguments.FID_funcionario)>

    <!--- <cfset variables.arquivo = "">
  
    <cfif isBinary(arguments.arquivo)>
      <cfset variables.arquivo = arguments.arquivo>
    <cfelse>
      <cfset variables.arquivo = javaCast("null", "")>
    </cfif> --->

    <cfreturn this>
  </cffunction>

   
  <!--- Set --->
  <cffunction name="setTipoAusencia" access="public" returntype="void">
    <cfargument name="tipoAusencia" type="numeric">
    <cfset variables.tipoAusencia = arguments.tipoAusencia>
  </cffunction>

  <cffunction name="setDataInicio" access="public" returntype="void">
    <cfargument name="dataInicio" type="date">
    <cfset variables.dataInicio = arguments.dataInicio>
  </cffunction>

  <cffunction name="setDataFim" access="public" returntype="void">
    <cfargument name="dataFim" type="date">
    <cfset variables.dataFim = arguments.dataFim>
  </cffunction>

  <cffunction name="setRazao" access="public" returntype="void">
    <cfargument name="razao" type="string">
    <cfset variables.razao = arguments.razao>
  </cffunction>

  <!--- <cffunction name="setArquivo" access="public" returntype="void">
    <cfargument name="arquivo" type="any">
    <cfset variables.arquivo = arguments.arquivo>
  </cffunction> --->

  <cffunction name="setFID_funcionario" access="public" returntype="void">
    <cfargument name="FID_funcionario" type="string">
    <cfset variables.FID_funcionario = arguments.FID_funcionario>
  </cffunction>

  

  <!--- Get --->

  <cffunction name="getTipoAusencia" access="public" returntype="numeric">
    <cfreturn variables.tipoAusencia>
  </cffunction>
  
  <cffunction name="getDataInicio" access="public" returntype="date">
    <cfreturn variables.dataInicio>
  </cffunction>
  
  <cffunction name="getDataFim" access="public" returntype="date">
    <cfreturn variables.dataFim>
  </cffunction>
  
  <cffunction name="getRazao" access="public" returntype="string">
    <cfreturn variables.razao>
  </cffunction>

  <cffunction name="getFID_funcionario" access="public" returntype="string">
    <cfreturn variables.FID_funcionario>
  </cffunction>

 <!---  <cffunction name="getArquivo" access="public" returntype="any">
    <cfreturn variables.arquivo>
  </cffunction> --->



</cfcomponent>