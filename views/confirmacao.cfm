<link href="../assets/CSS/index.css" rel="stylesheet" type="text/css"/>

<cfinclude template="../views/templates/header_confirmacao.cfm">
 
  <!-- Formulário de Confirmação -->

  <div class="accountbg"></div>
  <div class="wrapper-page">
    <div class="card shadow">
      <div class="card-body">
        <div class="p-3">
          <form class="form-horizontal m-t-20" action="agenda.cfm" method="post" name="submitButton" id="submitButton" value="Login">
            <div class="form-group row">
              <label>Nome Completo</label>
                <input type="text" class="form-control" value="Nome completo">
            </div>

            <div class="form-group row">
              <label>Email</label> 
              <input type="email" class="form-control" value="email@email.com">
            </div>
          
            <div class="form-group row">
              <label>Departamento </label> <!---<i class="bi bi-caret-down-fill"></i>--->
              <select class="form-control" > 
                <option>Departamento de Administração Geral</option>
                <option>Departamento de Gestão Financeira e Contratualização</option>
                <option>Departamento de Sistemas de Informação e Comunicação</option>
              </select>
            </div>

            <div class="form-group row">
              <label>Data Admissão</label>
              <input type="date" class="form-control" value="2023-01-01"> 
            </div>
              <button class="btn btn-info btn-block">Confirmar</button>
          </form>
        </div>
      </div>
    </div>
  </div>

</body>
</html>