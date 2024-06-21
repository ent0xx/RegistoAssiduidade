document.addEventListener('DOMContentLoaded', function () {
  var modal = document.getElementById('pedidoModal');
  
  document.querySelectorAll('.marcacaodireta').forEach(function(button) {
    button.addEventListener('click', function() {
      var row = button.closest('tr.funcionario-row');
      
      var idFuncionario = row.dataset.id;
      
      var nomeCompleto = row.querySelector('.nome-completo').textContent;
      
      var inputIdFuncionario = modal.querySelector('#FID_funcionario');
      var inputNomeCompleto = modal.querySelector('#nome');
      
      inputIdFuncionario.value = idFuncionario;
      inputNomeCompleto.value = nomeCompleto;
    });
  });
});
