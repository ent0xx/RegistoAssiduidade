<cfcomponent>

  <cffunction name="getFuncionarios" access="public" returntype="query" output="false">
    <cfquery name="getFuncionarios" datasource="#application.dsn#">
        SELECT ias_funcionario.id_funcionario, ias_funcionario.nome_completo, ias_funcionario.FID_organica, ias_funcionario.FID_utilizador, ias_funcionario.data_admissao, ias_funcionario.ativo, ias_departamento.departamento, ias_departamento.id_departamento
        FROM ias_funcionario
        INNER JOIN ias_organica ON ias_funcionario.FID_organica = ias_organica.id_organica
        INNER JOIN ias_departamento ON ias_organica.FID_departamento = ias_departamento.id_departamento
    </cfquery>
    <cfreturn getFuncionarios>
  </cffunction>

  <!--- Exportar o saldo (dias disponiveis) de cada Funcionario --->
  <cffunction name="getSaldosFuncionarios" access="public" returntype="query" output="false">
    <cfquery name="getSaldosFuncionarios" datasource="#application.dsn#">
      SELECT id_saldo, FID_funcionario, FID_tipo_ausencia, FID_utilizador_alteracao, saldo, ano, ativo
      FROM dbo.ias_saldo_funcionario
    </cfquery>
    <!-- cfreturn getSaldosFuncionarios -->
  </cffunction>

  <cffunction name="getDepartamentos" access="public" returntype="query" output="false">
    <cfquery name="queryDepartamentos" datasource="#application.dsn#">
      SELECT id_departamento, departamento
      FROM ias_departamento
      ORDER BY departamento
    </cfquery>
    
    <cfreturn queryDepartamentos>
  </cffunction>

</cfcomponent>
