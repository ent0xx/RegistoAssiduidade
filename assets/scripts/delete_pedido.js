$(document).ready(function() {
  $('.removeBtn').on('click', function() {
    var idPedidoAusencia = $(this).closest('tr').attr('idPedido');
    
    if (confirm('Tem certeza que quer remover o pedido?')) {
      $.ajax({
        type: 'POST',
        url: '../../ausencias/controllers/pedido.cfc?method=deletarPedido',
        data: { pedidoID: idPedidoAusencia },
        dataType: 'json',
        success: function(response) {
          if (response.SUCCESS) {
            alert('O pedido foi removido com sucesso!');
            window.location.reload();
          } else {
            alert('Erro ao remover: ' + response.MESSAGE);
          }
        },
        error: function(xhr, status, error) {
          alert('AJAX error: ' + error);
          console.error('AJAX Error:', error);
        }
      });
    }
  });
});