<cfcomponent displayname="PedidosController" output="false">

  <cfset variables.pedidoModelo = {
    msgErro = "",
    xpto = 0
  } />

  <cfset variables.pedidosDAO = createObject("component", "models.DAO.pedido_dao")/>

  <!--- Métodos Públicos --->

  <cffunction name="getPedidos" access="public" returntype="query" output="false">
    <cfargument name="dataInicio" type="date" required="false"/>
    <cfargument name="dataFim" type="date" required="false"/>
    <cfargument name="estado" type="numeric" required="false" default="0" />
    <cfargument name="tipoAusencia" type="numeric" required="false" default="0" />
    <cfargument name="paginaAtual" type="numeric" required="false" default="1">
    <cfargument name="pedidosPorPagina" type="numeric" required="false" default="6">

    <cfset var ausenciaBean = createObject("component", "models.BEAN.pedido_bean")/>
    <cfset ausenciaBean.setDataInicio(arguments.dataInicio)>
    <cfset ausenciaBean.setDataFim(arguments.dataFim)>
    <cfset ausenciaBean.setEstado(arguments.estado)>
    <cfset ausenciaBean.setTipoAusencia(arguments.tipoAusencia)>
    <cfset ausenciaBean.setPaginaAtual(arguments.paginaAtual)>
    <cfset ausenciaBean.setPedidosPorPagina(arguments.pedidosPorPagina)>
    <cfset ausenciaBean.setFID_funcionario(Session.MM_UserID)>
    <cfreturn variables.pedidosDAO.getPedidos(ausenciaBean)/>
    
  </cffunction>  

  <cffunction name="ObterPedidoPorIdPedidoAusencia" access="remote" output="false" returntype="any" returnFormat="JSON">
    <cfargument name="idPedidoAusencia" type="numeric" required="false" default="0" />
    
    <cfreturn serializeJSON(createObject("component", "models.DAO.pedido_dao").GetPedidoByIdPedidoAusencia(idPedidoAusencia), "column") />
  </cffunction>

  <cffunction name="countPedidos" access="public" returntype="numeric">
    <cfargument name="dataInicio" type="date" required="true" />
    <cfargument name="dataFim" type="date" required="true"  />
    <cfargument name="estado" type="numeric" required="false" default="0" />
    <cfargument name="tipoAusencia" type="string">
    
    <cfset var totalCount = variables.pedidosDAO.countPedidos(arguments.dataInicio, arguments.dataFim, arguments.estado, arguments.tipoAusencia)>
    <cfreturn totalCount>
  </cffunction>

  <cffunction name="getTiposAusencia" access="public" returntype="query" output="false">
    <cfreturn variables.pedidosDAO.getTiposAusencia()>
  </cffunction>


  <cffunction name="init" access="public" returntype="component">
    <cfargument name="PedidoAusenciaDAO" type="any" required="true">
    <cfset variables.PedidoAusenciaDAO = arguments.PedidoAusenciaDAO>
    <cfreturn this>
  </cffunction>

  
  <cffunction name="confirmarPedido" access="remote" output="false" returntype="any" returnFormat="JSON">
    <cfargument name="infoPedido" type="struct" required="true" >
    <cfset pedidoInserido = createObject("component", "models.DAO.pedido_dao").updatePedidoAusencia(arguments.infoPedido) />
    <!--- Tratar MSG de erro caso false. 
    <cfif NOT pedidoInserido >
      <cfset variables.pedidoModelo.msgErro = "Erro no Coldfusion... #pedidoInserido#" />
    </cfif>
    --->
    <cfset variables.pedidoModelo.msgErro = pedidoInserido />

    <cfreturn variables.pedidoModelo>
  </cffunction>

  <cffunction name="deletarPedido" access="remote" returnformat="json" output="false">
    <cfargument name="pedidoID" type="numeric" required="yes">

    <cfset var response = {SUCCESS = false, MESSAGE = ''}>

      <cftry>
        <cfset var result = pedidosDAO.deletarPedido(arguments.pedidoID)>

        <cfif result>
          <cfset response.SUCCESS = true>
          <cfset response.MESSAGE = "Pedido removido!">
        <cfelse>
          <cfset response.MESSAGE = "Falha ao remover o Pedido.">
        </cfif>

        <cfcatch type="any">
          <cfset response.MESSAGE = "Exception: #cfcatch.message#">
        </cfcatch>
      </cftry>


    <cfreturn response>
  </cffunction>

  <cffunction name="logout" access="remote" returntype="any" returnFormat="JSON" output="false">
    <cfset structClear( Session ) />
  </cffunction>

</cfcomponent>
