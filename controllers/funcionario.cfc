<cfcomponent>

  <cfset variables.funcionarioDAO = createObject("component", "models.DAO.funcionario_dao")>

  <cffunction name="getFuncionarios" access="public" returnformat="json" returntype="query" output="false">
    <cfreturn variables.funcionarioDAO.getFuncionarios()>
  </cffunction>

  <cffunction name="getSaldosFuncionarios" access="public" returntype="query" output="false">
      <!-- cfreturn variables.funcionarioDAO.getSaldosFuncionarios() -->
  </cffunction>

  <cffunction name="listarDepartamentos" access="public" returntype="query" output="false">

    <cfreturn variables.funcionarioDAO.getDepartamentos()>
  </cffunction>

</cfcomponent>