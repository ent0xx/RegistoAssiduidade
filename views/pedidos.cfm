<cfinclude template="../views/templates/header.cfm">

<cfif NOT isDefined("FORM.filtroEstado") OR NOT isNumeric(FORM.filtroEstado)>
  <cfset filtroEstado = 0>
<cfelse>
  <cfset filtroEstado = FORM.filtroEstado>
</cfif>

<cfset pedidosController = createObject("component", "controllers.pedido")/>

<cfset tiposAusencia = pedidosController.getTiposAusencia()>
<cfset allPedidos = pedidosController.getPedidos(dataInicioDate, dataFimDate, filtroEstado, tipoAusencia)>

 <div id="msgFeedback"></div>
<!---  <cfoutput>#Session.MM_UserID#</cfoutput> --->
<!--- <cfdump var="#allPedidos.recordCount#"> --->
 <!--- <cfdump var="#totalPedidos#"> --->
  <div class="container-fluid">
    <div class="row mb-3">
      <div class="col-md-3">
        <form id="FormEstado0" method="post">
          <input type="hidden" name="filtroEstado" value="0">
          <button  data-estado="0" class="btn pedidos-btn btn-outline-secondary shadow-sm w-100" onclick="selectButton(this);">Todos</button>
        </form>
      </div>
      <div class="col-md-3">
        <form id="FormEstado1" method="post">
          <input type="hidden" name="filtroEstado" value="1"  data-estado="1">
          <button  data-estado="1" class="btn pedidos-btn btn-outline-secondary shadow-sm w-100"  onclick="selectButton(this);">Pendente</button>
        </form>
      </div>
      <div class="col-md-3">
        <form id="FormEstado2" method="post">
          <input type="hidden" name="filtroEstado" value="2"  data-estado="2">
          <button  data-estado="2" class="btn pedidos-btn btn-outline-secondary shadow-sm w-100" onclick="selectButton(this);">Aprovado</button>
        </form>
      </div>
      <div class="col-md-3">
        <form id="FormEstado3" method="post">
          <input type="hidden" name="filtroEstado" value="3"  data-estado="3">
          <button  data-estado="3" class="btn pedidos-btn btn-outline-secondary shadow-sm w-100" onclick="selectButton(this);">Rejeitado</button>
        </form>
      </div>
    </div>
    <div class="row mb-3">
      <div class="col-md-12">
        <form  method="post"> 
          <input type="hidden" id="filtroEstado" name="filtroEstado" value="<cfoutput>#filtroEstado#</cfoutput>">
          <div class="border p-5">
            <div class="row">
              <div class="col-md-3">
                <label>Data Inicial:</label>
                <input type="date" class="form-control" id="dataInicio" name="dataInicio">
              </div>
              <div class="col-md-3">
                <label>Data Final:</label>
                <input type="date" class="form-control" id="dataFim" name="dataFim">
              </div>
              <div class="col-md-3">
              <label>Tipo Ausencia:</label>
              <select id="dropdownTipoAusencia" class="form-select" name="tipoAusencia">
                <option <cfif tipoAusencia EQ 0>selected</cfif> value="0">Todas</option>
                <cfloop query="tiposAusencia">
                  <cfoutput>
                    <option <cfif tipoAusencia EQ tiposAusencia.id_tipo_ausencia>selected</cfif> value="#tiposAusencia.id_tipo_ausencia#">#tiposAusencia.tipo_ausencia#</option>
                  </cfoutput>
                </cfloop>
              </select>
              </div>
              <div class="col-md-3 d-flex align-items-end">
                <button id="botaoPesquisa" name="botaoPesquisa" type="submit" class="btn pedidos-btn btn-outline-secondary w-100">Pesquisar</button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12 mb-3">
      <div class="card">
        <div class="card-header">
          <span><i class="bi bi-table me-2"></i></span> Tabela de Ausencias
        </div>
        <div class="card-body">
          <div class="table-responsive">      
            <cfoutput>
              <table id="table" class="table table-striped table-bordered">
                <thead>
                  <tr class="text-center">
                    <th>Nome</th>
                    <th>Data de inicio</th>
                    <th>Data do fim</th>
                    <th>Falta</th>
                    <th>Observações</th>
                    <th>Estado</th>
                    <th>Opções</th>
                  </tr>
                </thead>
                <tbody>
                  <!--- <td>#allPedidos.id_pedido_ausencia#</td> --->
                  <cfloop query="allPedidos">
                    <tr idPedido="#allPedidos.id_pedido_ausencia#" idEstado="#allPedidos.id_estado#">
                      <!--- <cfdump var=#allPedidos#> --->
                      <td>#allPedidos.nome_completo#
                      <td class="text-center">#dateFormat(allPedidos.dataInicio, "dd-mm-yyyy")#</td>
                      <td class="text-center">#dateFormat(allPedidos.dataFim, "dd-mm-yyyy")#</td>
                      <td>#allPedidos.tipo_ausencia#</td>
                      <td class="limite-comentario justify-text" data-bs-placement="top" title="#allPedidos.comentario#">#allPedidos.comentario#</td>
                      <td class="text-center">#allPedidos.estado#</td>
                      <td class="text-center">
                          <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuOpcoes" data-bs-toggle="dropdown"><i class="bi bi-list"></i></button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuOpcoes">
                              <cfif SESSION.MM_NivelAcesso EQ "Administrador">
                                <cfif allPedidos.id_estado EQ 1>
                                  <li><a class="successBtn dropdown-item"  data-bs-toggle="modal" data-bs-target="##modalaprovar">Gerir Pedido</a></li>
                                  <li><a class="removeBtn dropdown-item" >Remover</a></li>
                                <cfelse>
                                  <li><a class="removeBtn dropdown-item" >Remover</a></li>
                                </cfif>
                              <cfelse>
                                <li><a class="successBtn dropdown-item" data-bs-toggle="modal" data-bs-target="##modalaprovar">Informações Pedido</a></li>
                              </cfif>

                              <!--- <li><a class="dropdown-item" data-id="#allPedidos.id_pedido_ausencia#">Download Arquivo</a></li> --->
                            </ul>
                          </div>
                      </td>
                    </tr>
                  </cfloop>
                </tbody>
              </table>
            </cfoutput>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!--- Modal Confirmar/Rejeitar Pedido action="pedidos.cfm" --->
  <form class="needs-validation" id="confirmForm" method="POST">
    <div class="modal fade" id="modalaprovar" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-custom-width">
        <div class="modal-content">
          <!--- Estado e id do pedido no modal (hidden) --->
          <input type="hidden" id="estadoModal" name="estado">
          <input type="hidden" id="idPedidoAusenciaModal" name="idPedidoAusencia">
          <div class="modal-header">
            <cfif SESSION.MM_NivelAcesso EQ "Administrador">
              <h5 class="modal-title" id="modalpendenteLabel">Gerir Pedido</h5>
            <cfelse>
              <h5 class="modal-title" id="modalpendenteLabel">Informações Pedido</h5>
            </cfif>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label">Nome:</label>
              <input class="form-control" type="text" id="modalNome" name="modalNome" placeholder="Nome Exemplo" disabled>
            </div>
            <div class="mb-3">
              <label class="form-label">Selecione as datas:</label>
              <div class="input-group">
                  <cfif SESSION.MM_NivelAcesso EQ "Administrador">
                    <span class="input-group-text">De:</span>
                    <input type="date" class="form-control" id="modalDataInicio" name="modalDataInicio">
                    <span class="input-group-text ms-3">Até:</span>
                    <input type="date" class="form-control" id="modalDataFim" name="modalDataFim">
                  <cfelse>
                    <span class="input-group-text">De:</span>
                    <input type="date" class="form-control" id="modalDataInicio" name="modalDataInicio" disabled>
                    <span class="input-group-text ms-3">Até:</span>
                    <input type="date" class="form-control" id="modalDataFim" name="modalDataFim" disabled>
                  </cfif>
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label">Falta:</label>
              <input class="form-control" type="text" id="modalFalta" name="modalFalta" disabled>
            </div>
            <div class="mb-3">
              <label for="razao" class="form-label">Observações:</label>
              <cfif SESSION.MM_NivelAcesso EQ "Administrador">
                <textarea class="form-control" id="modalRazao" name="modalRazao" ></textarea>
              <cfelse>
                <textarea class="form-control" id="modalRazao" name="modalRazao" disabled></textarea>
              </cfif>
            </div>
            <div class="mb-3">
              <label for="formFile" class="form-label">Anexar arquivo</label>
              <input type="file" class="form-control" id="formFile" name="formFile" disabled>
            </div>
            <h4 class="modal-title text-center" id="modalDias"></h4>
            <div class="modal-footer">
              <cfif SESSION.MM_NivelAcesso EQ "Administrador">
                <button type="submit" class="btn btn-secondary rejectBtn" onclick="trySubmit(3)">Recusar</button>
                <button type="submit" class="btn btn-success confirmBtn" id="modalConfirmar" onclick="trySubmit(2)" data-id-pedido="">Confirmar</button>         
              </cfif>
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>  

<!--Footer-->
<cfinclude template="../views/templates/paginacao.cfm">


<!--- JavaScript --->
<script src="../assets/scripts/botoes_filtro.js"></script>
<script src="../assets/scripts/modal_pedidos.js"></script>
<script src="../assets/scripts/paginacao.js"></script> 
<script src="../assets/scripts/delete_pedido.js"></script>

<!--Footer-->
<cfinclude template="../views/templates/footer.cfm">




  