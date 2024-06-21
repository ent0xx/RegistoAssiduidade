<cfcomponent>

  
  <!--- getters / setters --->
  <cffunction name="setDataInicio" access="public" returntype="void">
    <cfargument name="dataInicio" type="date" required="true">
    <cfset variables.dataInicio = arguments.dataInicio>
  </cffunction>
  <cffunction name="getDataInicio" access="public" returntype="date">
    <cfreturn variables.dataInicio>
  </cffunction>

  <cffunction name="setDataFim" access="public" returntype="void">
    <cfargument name="dataFim" type="date" required="true">
    <cfset variables.dataFim = arguments.dataFim>
  </cffunction>
  <cffunction name="getDataFim" access="public" returntype="date">
    <cfreturn variables.dataFim>
  </cffunction>

  <cffunction name="setEstado" access="public" returntype="void">
    <cfargument name="estado" type="numeric" required="true">
    <cfset variables.estado = arguments.estado>
  </cffunction>


  <cffunction name="getEstado" access="public" returntype="numeric">
    <cfreturn variables.estado>
  </cffunction>

  <cffunction name="setTipoAusencia" access="public" returntype="void">
    <cfargument name="tipoAusencia" type="numeric" required="true">
    <cfset variables.tipoAusencia = arguments.tipoAusencia>
  </cffunction>
  <cffunction name="getTipoAusencia" access="public" returntype="numeric">
    <cfreturn variables.tipoAusencia>
  </cffunction>

  <cffunction name="setPaginaAtual" access="public" returntype="void">
    <cfargument name="paginaAtual" type="numeric" required="true">
    <cfset variables.paginaAtual = arguments.paginaAtual>
  </cffunction>
  <cffunction name="getPaginaAtual" access="public" returntype="numeric">
    <cfreturn variables.paginaAtual>
  </cffunction>

  <cffunction name="setPedidosPorPagina" access="public" returntype="void">
    <cfargument name="pedidosPorPagina" type="numeric" required="true">
    <cfset variables.pedidosPorPagina = arguments.pedidosPorPagina>
  </cffunction>
  <cffunction name="getPedidosPorPagina" access="public" returntype="numeric">
    <cfreturn variables.pedidosPorPagina>
  </cffunction>

  <cffunction name="setFID_funcionario" access="public" returntype="void">
    <cfargument name="FID_funcionario" type="numeric" required="true">
    <cfset variables.FID_funcionario = arguments.FID_funcionario>
  </cffunction>
  <cffunction name="getFID_funcionario" access="public" returntype="numeric">
    <cfreturn variables.FID_funcionario>
  </cffunction>

  


</cfcomponent>