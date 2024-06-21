<cfcomponent output="false">

  <!--- Métodos Públicos --->
  
  <!--- Retirar pedidos da tabela ias_pedido_ausencia --->
  <cffunction name="getPedidos" access="public" returntype="query">
    <cfargument name="ausenciaBean" type="models.bean.pedido_bean" required="true">
    <cfset var qPedidos = '' />
    
    <cfquery name="qPedidos" datasource="#application.dsn#">
      SELECT ias_pedido_ausencia.id_pedido_ausencia, ias_funcionario.nome_completo, ias_pedido_ausencia.data_inicio as dataInicio, ias_pedido_ausencia.data_fim as dataFim, ias_tipo_ausencia.tipo_ausencia, ias_pedido_ausencia.comentario, ias_estado.id_estado, ias_estado.estado, ias_pedido_ausencia.anexo, ias_pedido_ausencia.FID_funcionario
      FROM ias_pedido_ausencia
      INNER JOIN ias_funcionario ON ias_pedido_ausencia.FID_funcionario = ias_funcionario.id_funcionario
      INNER JOIN ias_tipo_ausencia ON ias_pedido_ausencia.FID_tipo_ausencia = ias_tipo_ausencia.id_tipo_ausencia
      INNER JOIN ias_estado ON ias_pedido_ausencia.FID_estado = ias_estado.id_estado
      WHERE ias_pedido_ausencia.ativo = 1
        AND ias_pedido_ausencia.data_inicio >= <cfqueryparam cfsqltype="cf_sql_date" value="#ausenciaBean.getDataInicio()#" />
        AND ias_pedido_ausencia.data_fim <= <cfqueryparam cfsqltype="cf_sql_date" value="#ausenciaBean.getDataFim()#" />
        <cfif Session.MM_NivelAcesso NEQ "Administrador">
          AND ias_funcionario.FID_utilizador = <cfqueryparam cfsqltype="cf_sql_integer" value="#ausenciaBean.getFID_funcionario()#" />
        </cfif>
      <cfif ausenciaBean.getEstado() NEQ 0>
        AND ias_estado.id_estado = <cfqueryparam cfsqltype="cf_sql_integer" value="#ausenciaBean.getEstado()#" />
      </cfif>
      <cfif ausenciaBean.getTipoAusencia() NEQ 0>
        AND ias_tipo_ausencia.id_tipo_ausencia = <cfqueryparam cfsqltype="cf_sql_integer" value="#ausenciaBean.getTipoAusencia()#" />
      </cfif>
      ORDER BY ias_pedido_ausencia.data_inicio DESC
    </cfquery>

    
    <cfreturn qPedidos />
  </cffunction>


  <cffunction name="GetPedidoByIdPedidoAusencia" access="public" returntype="query">
    <cfargument name="idPedidoAusencia" type="any" required="true">
    <cfset var qPedidos = '' />
    
    <cfquery name="qPedidos" datasource="#application.dsn#">
      SELECT ias_pedido_ausencia.id_pedido_ausencia, ias_funcionario.nome_completo, ias_pedido_ausencia.data_inicio as dataInicio, ias_pedido_ausencia.data_fim as dataFim, ias_tipo_ausencia.tipo_ausencia, ias_pedido_ausencia.comentario, ias_estado.id_estado, ias_estado.estado
      FROM ias_pedido_ausencia
      INNER JOIN ias_funcionario ON ias_pedido_ausencia.FID_funcionario = ias_funcionario.id_funcionario
      INNER JOIN ias_tipo_ausencia ON ias_pedido_ausencia.FID_tipo_ausencia = ias_tipo_ausencia.id_tipo_ausencia
      INNER JOIN ias_estado ON ias_pedido_ausencia.FID_estado = ias_estado.id_estado
      WHERE ias_pedido_ausencia.id_pedido_ausencia = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.idPedidoAusencia#" />
    </cfquery>
    
    <cfreturn qPedidos />
  </cffunction>


  <!--- Retirar Tipos de Ausencia da db --->
  <cffunction name="getTiposAusencia" access="public" returntype="query">
    <cfquery name="getTiposAusencia" datasource="#application.dsn#">
      SELECT id_tipo_ausencia, tipo_ausencia
      FROM ias_tipo_ausencia
      WHERE ativo = 1
    </cfquery>

    <cfreturn getTiposAusencia>
  </cffunction>

  <cffunction name="updatePedidoAusencia" access="public" returntype="any">
    <cfargument name="infoPedido" type="struct" required="true" >
    <cfset boolSuccess	= true />
    <cftry>

      <cfquery name="updatePedidoAusencia" datasource="#application.dsn#">
        UPDATE ias_pedido_ausencia
        SET FID_estado = <cfqueryparam value="#arguments.infoPedido.estado#" cfsqltype="cf_sql_integer">,
          data_inicio = <cfqueryparam value="#arguments.infoPedido.modalDataInicio#" cfsqltype="cf_sql_date">,
          data_fim = <cfqueryparam value="#arguments.infoPedido.modalDataFim#" cfsqltype="cf_sql_date">,
          comentario = <cfqueryparam value="#arguments.infoPedido.modalRazao#" cfsqltype="cf_sql_varchar">
        WHERE id_pedido_ausencia = <cfqueryparam value="#arguments.infoPedido.idPedidoAusencia#" cfsqltype="cf_sql_integer">
      </cfquery>
    
      <cfcatch type="database">
        <cfset boolSuccess = false />
      </cfcatch>
    
    </cftry>

    <cfreturn boolSuccess />
  </cffunction>


  <cffunction name="deletarPedido" access="public" returntype="boolean">
    <cfargument name="pedidoID" type="numeric" required="yes">

    <cfset var queryResult = false>

    <cfquery datasource="#application.dsn#">
      UPDATE ias_pedido_ausencia
        SET ativo = 0
        WHERE id_pedido_ausencia = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pedidoID#">
    </cfquery>

    <cfset queryResult = true>

    <cfreturn queryResult>
  </cffunction>

  

  
</cfcomponent>