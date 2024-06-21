<cfcomponent displayname="PedidoController" output="false">

  <cffunction name="inserePedido" access="remote" returntype="void">
    <cfargument name="tipoAusencia" type="numeric" required="false">
    <cfargument name="dataInicio" type="date" required="false">
    <cfargument name="dataFim" type="date" required="false">
    <cfargument name="razao" type="string" required="false">
    <cfargument name="FID_funcionario" type="numeric" required="false">

    <!--- <!--- Verificação se o campo do arquivo está vazio --->
    <cfif structKeyExists(form, "formFile") and len(trim(form.formFile))>
      <cffile action="upload" filefield="formFile" destination="#GetTempDirectory()#" nameconflict="makeunique">
      <cfset fileData = fileReadBinary(cffile.serverDirectory & "/" & cffile.serverFile)>
    </cfif> --->

    <cfset var pedidoBean = createObject("component", "models.BEAN.novo_pedido_bean")/>
    <cfset pedidoBean.settipoAusencia(arguments.tipoAusencia)>
    <cfset pedidoBean.setdataInicio(arguments.dataInicio)>
    <cfset pedidoBean.setdataFim(arguments.dataFim)>
    <cfset pedidoBean.setrazao(arguments.razao)>
    <cfset pedidoBean.setFID_funcionario(arguments.FID_funcionario)>


    <cfset var novoPedidoDAO = createObject("component", "models.DAO.novo_pedido_dao")>
    <cfset novoPedidoDAO.inserePedido(pedidoBean)>
  </cffunction>


  <cffunction name="getPedidosCalendario" access="remote" returnformat="JSON">
    <cfargument name="FID_funcionario" type="numeric" required="yes">
    
    <cfset var pedidosDAO = createObject("component", "models.DAO.novo_pedido_dao")>
    
    <cfset var pedidosQuery = pedidosDAO.getPedidosCalendario(arguments.FID_funcionario)>
    <cfset var pedidosArray = []>
    
    <cfloop query="pedidosQuery">
      <cfset pedido = {
        'title': pedidosQuery.tipo_ausencia,
        'start': pedidosQuery.data_inicio,
        'end': pedidosQuery.data_fim,
        'id_tipo_ausencia': pedidosQuery.FID_tipo_ausencia,
        'id_estado': pedidosQuery.FID_estado
      }>
      <cfset arrayAppend(pedidosArray, pedido)>
    </cfloop>
    
    <cfreturn serializeJSON(pedidosArray)>
  </cffunction>

  <cffunction name="getPendingPedidosCount" access="remote" returnformat="JSON" output="false">
    <cfargument name="FID_funcionario" type="numeric" required="yes">

    <cfset var pedidoDAO = createObject("component", "models.DAO.novo_pedido_dao")>

    <cfset var count = pedidoDAO.getPendingPedidosCount(arguments.FID_funcionario)>

    <cfreturn { "count": count }>
  </cffunction>
  


 
</cfcomponent>
