<cfcomponent>

  <cffunction name="inserePedido" access="public" returntype="void">
    <cfargument name="pedidoBean" type="any" required="true">

    
    <cfquery name="insertPedido" datasource="#application.dsn#">
      INSERT INTO ias_pedido_ausencia (FID_tipo_ausencia, FID_funcionario, data_inicio, data_fim, comentario, FID_estado)
      VALUES (
        <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pedidoBean.getTipoAusencia()#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pedidoBean.getFID_funcionario()#">,
        <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.pedidoBean.getDataInicio()#">,
        <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.pedidoBean.getDataFim()#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pedidoBean.getRazao()#">,
        <cfqueryparam cfsqltype="cf_sql_integer" value="1">
        <!--- <cfqueryparam cfsqltype="cf_sql_blob" value="#arguments.pedidoBean.getArquivo()#" null="#len(arguments.pedidoBean.getArquivo()) EQ 0#"> --->
      )
    </cfquery>

    <!--- <cflocation url="../../views/agenda.cfm?msg=success" addtoken="no"> --->
    <!--- <cfheader name="Location" value="#cgi.HTTP_REFERER#?msg=success"> --->
  </cffunction>


  <cffunction name="getAusencias" access="public" returntype="query">
    <cfargument name="userId" type="numeric" required="yes">

    <cfquery name="ausencias" datasource="#application.dsn#">
      SELECT ias_pedido_ausencia.id_pedido_ausencia, ias_pedido_ausencia.FID_tipo_ausencia, ias_pedido_ausencia.FID_funcionario, ias_pedido_ausencia.data_inicio, ias_pedido_ausencia.data_fim, ias_tipo_ausencia.tipo_ausencia
      FROM ias_pedido_ausencia
      JOIN ias_tipo_ausencia
      ON ias_pedido_ausencia.FID_tipo_ausencia = ias_tipo_ausencia.id_tipo_ausencia
      WHERE ias_pedido_ausencia.FID_funcionario = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfreturn ausencias>
  </cffunction>

  <cffunction name="getPedidosCalendario" access="public" returntype="query">
    <cfargument name="FID_funcionario" type="numeric" required="yes">
    
    <cfquery name="getPedidosQuery" datasource="#application.dsn#">
      SELECT ias_pedido_ausencia.data_inicio, ias_pedido_ausencia.data_fim, ias_tipo_ausencia.tipo_ausencia, ias_pedido_ausencia.FID_tipo_ausencia, ias_pedido_ausencia.FID_estado, ias_pedido_ausencia.FID_funcionario
      FROM ias_pedido_ausencia
      INNER JOIN ias_funcionario ON ias_pedido_ausencia.FID_funcionario = ias_funcionario.id_funcionario
      INNER JOIN ias_tipo_ausencia ON ias_pedido_ausencia.FID_tipo_ausencia = ias_tipo_ausencia.id_tipo_ausencia
      INNER JOIN ias_estado ON ias_pedido_ausencia.FID_estado = ias_estado.id_estado
      WHERE ias_pedido_ausencia.ativo = 1
        AND ias_pedido_ausencia.FID_funcionario = <cfqueryparam value="#arguments.FID_funcionario#" cfsqltype="cf_sql_integer">
        AND ias_pedido_ausencia.FID_estado = 2
    </cfquery>
    <cfreturn getPedidosQuery>
  </cffunction>

  <cffunction name="getPendingPedidosCount" access="public" returntype="numeric">
    <cfargument name="FID_funcionario" type="numeric" required="yes">
    
    <cfquery name="queryPedidosPendentes" datasource="#application.dsn#">
      SELECT COUNT(*) AS count
      FROM ias_pedido_ausencia
      WHERE ativo = 1
        AND FID_funcionario = <cfqueryparam value="#arguments.FID_funcionario#" cfsqltype="cf_sql_integer">
        AND FID_estado = 1
    </cfquery>

    <cfdump var="#queryPedidosPendentes#" label="Query Result">
    
    <cfreturn queryPedidosPendentes.count>
  </cffunction>


</cfcomponent>

