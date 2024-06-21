var fidFuncionario = $('#FID_funcionario').val();

$.ajax({
  type: "GET",
  url: "../../ausencias/controllers/agenda.cfc?method=getPendingPedidosCount",
  dataType: "json",
  data: {
    FID_funcionario: fidFuncionario
  },
  success: function(response) {
    $('.pendentes').text(response.count);

  },
  error: function(xhr, status, error) {
    console.error('AJAX Error: ' + status + ' - ' + error);
    $('.pendentes').text("Erro");
  }
});
