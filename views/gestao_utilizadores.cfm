<cfinclude template="../views/templates/header.cfm">

<cfset funcionarioController = createObject("component", "controllers.funcionario")>
<cfset pedidosController = createObject("component", "controllers.pedido")/>

<cfset funcionarios = funcionarioController.getFuncionarios()>
<cfset departamentos = funcionarioController.listarDepartamentos()>
<cfset tiposAusencia = pedidosController.getTiposAusencia()>

<!--- <cfset saldosFuncionarios = funcionarioController.getSaldosFuncionarios()> --->

  <form id="filtroDepartamento" method="post" action="">
    <div class="border p-5">
      <div class="row">
        <div class="col-md-3">
          <label>Nome:</label>
          <select class="form-select" id="nomeSelect" name="nome">
            <cfoutput query="funcionarios">
              <option>#nome_completo#</option>
            </cfoutput>
          </select>    
        </div>
        <div class="col-md-5">
          <label>Departamento:</label>
          <select class="form-select" id="departamentoSelect" name="departamento">
            <cfoutput query="departamentos">
              <option value="#departamentos.id_departamento#">#departamentos.departamento#</option>
            </cfoutput>
          </select>
        </div>
        <div class="col-md-4">
          <button type="submit" class="btn pedidos-btn btn-outline-secondary w-100">Pesquisar</button>
        </div>
      </div>
    </div>
  </form>
  <br>
  <div class="row">
    <div class="col-md-12 mb-3">
      <div class="card">
        <div class="card-header">
          <span><i class="bi bi-table me-2"></i></span> Tabela de Ausencias
        </div>
        <div class="card-body">
          <br>
          <div class="table-responsive">
            <table id="table" class="table table-striped table-bordered">
              <thead>
                <tr class="text-center">
                  <th>Nome</th>
                  <th>Data Admissão</th>
                  <th>Dias Disponíveis</th>
                  <th>Departamento</th>
                  <th>Marcação Direta</th> <!--- Administração conseguir marcar diretamente a ausencia || Talvez colocar no dropdown nas opções --->
                  <th>Opções</th>
                </tr>
              </thead>
              <tbody>
                <cfoutput query="funcionarios">
                  <tr class="funcionario-row" data-id="#id_funcionario#">
                    <td class="nome-completo">#nome_completo#</td>
                    <td class="text-center">#dateFormat(data_admissao, "dd-mm-yyyy")#</td>
                    <td>&nbsp;</td><!--- Saldo --->
                    <td>#departamento#</td>
                    <td class="text-center"><button type="button" class="btn btn-secondary marcacaodireta" data-bs-toggle="modal" data-bs-target="##pedidoModal"><i class="bi bi-plus-circle"></i></button></td>
                    <td class="text-center">
                      <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuOpcoes" data-bs-toggle="dropdown"><i class="bi bi-list"></i></button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuOpcoes">
                          <li><a class="successBtn dropdown-item" id="successBtn" data-bs-toggle="modal" data-bs-target="##UtilizadorModal">Gerir Utilizador</a></li>
                        </ul>
                      </div>
                    </td>
                  </tr>
                </cfoutput>
              </tbody>
            </table>
          </div>
        </div>


        <!-- Modal Marcação direta -->
        <form action="../../ausencias/controllers/agenda.cfc?method=inserePedido" id="NovoPedidoForm" method="post" enctype="multipart/form-data">
          <div class="modal fade" id="pedidoModal" tabindex="-1" aria-labelledby="pedidoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-custom-width">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="pedidoModalLabel">Novo Pedido</h5>
                  <input type="hidden" id="FID_funcionario" name="FID_funcionario" value="" readonly>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                      <label for="nome" class="form-label">Nome:</label>
                      <input type="text" id="nome" name="nome" class="form-control" readonly>
                    </div>
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
                    <!--- <div class="mb-3">
                      <label for="formFile" class="form-label" >Anexar arquivo</label>
                      <input type="file" class="form-control" id="formFile" name="formFile" >
                    </div> --->
                    <div class="modal-footer">
                      <button type="submit" class="btn btn-primary" id="submitPedido" >Submeter pedido</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </form>
        <!--- Fim do Modal --->


        <!--- Modal Gestão Utilizador --->
        <form action="../../ausencias/controllers/agenda.cfc?method=" id="UtilizadorForm" method="post" enctype="multipart/form-data">
          <div class="modal fade" id="UtilizadorModal" tabindex="-1" aria-labelledby="UtilizadorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-custom-width">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="UtilizadorModalLabel">Gerir Utilizador</h5>
                  <input type="hidden" id="FID_funcionario" name="FID_funcionario" value="" readonly>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                      <label for="nome" class="form-label">Nome:</label>
                      <input type="text" id="nome" name="nome" class="form-control" >
                    </div>
                    <div class="mb-3">
                      <label for="tipoAusencia" class="form-label">Data Admissão:</label>
                      <input type="text" id="dataadmissao" name="dataadmissao" class="form-control" >
                    </div>
                    <hr>
                    <div class="mb-3">
                      <label for="dias" class="form-label">Dias Disponíveis:</label>
                      <input type="text" id="dias" name="dias" class="form-control" >
                    </div>

                    <div class="mb-3">
                      <label for="departamento" class="form-label">Departamento:</label>
                      <select id="dropdowndepartamento" class="form-select" name="departamento">
                        <option value="0" required>Selecione..</option>
                      </select>
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
      </div>
    </div>
  </div>


<!--Paginação-->
<cfinclude template="../views/templates/paginacao.cfm">

<!--- Scripts --->
<script src="../assets/scripts/paginacao.js"></script>
<script src="../assets/scripts/modal_utilizadores.js"></script>

<!--Footer-->
<cfinclude template="../views/templates/footer.cfm">
<!--- <cfinclude template="../views/paginacao.cfm"> --->
