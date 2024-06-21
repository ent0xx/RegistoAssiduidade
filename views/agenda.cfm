  <cfinclude template="../views/templates/header.cfm">
  
  <cfset pedidosController = createObject("component", "controllers.pedido")/>
  <cfset agendaController = createObject("component", "controllers.agenda")/>


  <cfset PedidosUtilizador = pedidosController.getPedidos(dataInicioDate, dataFimDate,tipoAusencia)>
  <cfset tiposAusencia = pedidosController.getTiposAusencia()> 
  
  <cfparam name="URL.FID_funcionario" default="0" type="numeric">

  <cfset getPedidosCalendario = agendaController.getPedidosCalendario(URL.FID_funcionario)>

  <!--- Observações   |   * para obrigatorio --->
    <!--- <cfoutput>#Session.MM_UserID#</cfoutput> --->
    <!--- <cfdump var="#getPendingPedidosCount#"> --->
      <div class="container-fluid">
        <div class="row">
          <!-- Cards -->
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-6 mb-4">
                  <div class="card bg-success text-white shadow text-center">
                      <div class="card-body py-5">
                          <h1 class="card-title fw-bold">0</h1>
                          <h5 class="card-text">Dias Disponíveis</h5>
                      </div>
                  </div>
              </div>
              <div class="col-md-6 mb-4">
                  <div class="teste card bg-primary text-white shadow text-center">
                      <div class="card-body py-5">
                        <cfoutput>
                          <h1 class="card-title fw-bold pendentes">0</h1>
                          <h5 class="card-text">Pedidos Pendentes</h5>
                        </cfoutput>
                      </div>
                  </div>
              </div>
          </div>
            <div class="row">
              <div class="col-md-12 mb-3">
                <hr class="width-hr">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#pedidoModal"> Novo Pedido </button>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 text-center logo_ia_container">
                <!--- <img src="../assets/images/logo_ias_full.png" alt="Logo" class="img-fluid logo_ia"> --->
              </div>
            </div>
          </div>
          <!-- Calendário -->
          <div class="col-md-6 mb-4">
            <cfinclude template="../views/templates/calendario.cfm">
          </div>
        </div>

        <!-- Modal Novo Pedido -->
        <form action="../../ausencias/controllers/agenda.cfc?method=inserePedido" id="NovoPedidoForm" method="post" enctype="multipart/form-data">
          <div class="modal fade" id="pedidoModal" tabindex="-1" aria-labelledby="pedidoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-custom-width">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="pedidoModalLabel">Novo Pedido</h5>
                  <input type="hidden" id="FID_funcionario" name="FID_funcionario" value="<cfoutput>#PedidosUtilizador.FID_funcionario#</cfoutput>"> <!--- ID funcionario que está autenticado --->
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                      <label for="tipoAusencia" class="form-label">Tipo de Ausencia</label>
                      <select id="dropdownTipoAusencia" class="form-select" name="tipoAusencia">
                        <option <cfif tipoAusencia EQ 0>selected</cfif> value="0" required>Selecione..</option>
                        <cfloop query="tiposAusencia">
                          <cfoutput>
                            <option <cfif tipoAusencia EQ tiposAusencia.id_tipo_ausencia>selected</cfif> value="#tiposAusencia.id_tipo_ausencia#">#tiposAusencia.tipo_ausencia#</option>
                          </cfoutput>
                        </cfloop>
                      </select>
                    </div>
                    <hr>
                    <div class="mb-3">
                      <label class="form-label">Selecione as datas:</label>
                      <div class="input-group">
                        <span class="input-group-text">De:</span>
                        <input type="date" class="form-control" id="dataInicio" name="dataInicio" required>
                        <span class="input-group-text ms-3">Até:</span>
                        <input type="date" class="form-control" id="dataFim" name="dataFim" required>
                      </div>
                    </div>
                    <hr>
                    <div class="mb-3">
                      <label for="razao" class="form-label">Observações:</label>
                      <textarea class="form-control" id="razao" name="razao"></textarea>
                    </div>
                    <div class="mb-3">
                      <label for="formFile" class="form-label" >Anexar arquivo</label>
                      <input type="file" class="form-control" id="formFile" name="formFile">
                    </div> 
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                      <button type="submit" class="btn btn-primary" id="submitPedido" >Submeter pedido</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </form>
        <!--- Fim do Modal --->
      </div>
    </main>


<script src="../assets/scripts/pedidos_pendentes.js"></script>
<!--Footer-->
<cfinclude template="../views/templates/footer.cfm">

  
  



