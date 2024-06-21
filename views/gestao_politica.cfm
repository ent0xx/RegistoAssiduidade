<cfinclude template="../views/templates/header.cfm">
<div class="container mt-5">

  <div class="card mb-4">
    <div class="card-header bg-primary text-white">
        Configurações de Ausência
    </div>
    <div class="card-body">
      <form>
          <div class="mb-3">
            <label for="absenceType" class="form-label">Tipo de Ausência</label>
            <select class="form-select" id="absenceType">
              <option selected>Escolha...</option>
              <option value="1">Férias</option>
              <option value="2">Licença Médica</option>
              <option value="3">Licença Maternidade</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="maxDays" class="form-label">Máximo de Dias para a Ausência</label>
            <input type="number" class="form-control" id="maxDays" min="0">
          </div>
          <div class="mb-3">
            <label for="maxMonthlyDays" class="form-label">Máximo de Dias de Ausência por ano para todos os Funcionários</label>
            <input type="number" class="form-control" id="maxMonthlyDays" min="0">
          </div>
          <button type="submit" class="btn btn-primary">Salvar</button>
      </form>
    </div>
  </div>
</div>
<!--Footer-->
<cfinclude template="../views/templates/footer.cfm">
