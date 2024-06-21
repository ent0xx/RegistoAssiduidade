function formatData(data) {

  // converte a data de "dd-mm-yyyy" para "yyyy-mm-dd"
  const partes = data.split("-");
  return partes[2] + "-" + partes[1] + "-" + partes[0];
}

function calcularDias(dataInicio, dataFim) {
  const partesInicio = dataInicio.split("-");
  const partesFim = dataFim.split("-");
  const inicio = new Date(partesInicio[0], partesInicio[1] - 1, partesInicio[2]);
  const fim = new Date(partesFim[0], partesFim[1] - 1, partesFim[2]);
  const diferenca = fim.getTime() - inicio.getTime();
  const dias = Math.ceil(diferenca / (1000 * 60 * 60 * 24));

  // Assim não retorna 0 dia(s) se o funcionario marcar só 1 dia ("de:" e "até:" ser igual)
  return dias >= 0 ? dias + 1 : 0;
}

function trySubmit(estado) {
  /* console.log(estado); */
  const confirmMsg = (estado == 2) ? 'Tem certeza que quer confirmar o pedido?' : 'Tem certeza que quer Recusar?';

  if (confirm(confirmMsg)) {

    const infoPedido = {};
    $('#confirmForm').serializeArray().map(function(obj){
      infoPedido[obj.name] = obj.value;
    });

    /* console.log(infoPedido); */
    infoPedido.estado = estado;

    $.ajax({
      url: '../../ausencias/controllers/pedido.cfc?method=ConfirmarPedido',
      type: 'post',
      data: {
        infoPedido: JSON.stringify(infoPedido)
      }, //FALTA TARTAR O ERRO...

      error: function(xhr, status, error) {
        const err = eval('(' + xhr.responseText + ')');

        const titulo = 'Erro';
        const mensagemErro = 'Não foi possivel confirmar/rejeitar o pedido';
        $('#modalaprovar').modal('toggle');
        $('#msgFeedback').html(
          '<div class="alert alert-dismissible alert-info">' +
            '<h5>' + titulo + '</h5><ul><li>' + mensagemErro + '</li></ul>' +
            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
          '</div>'
        );
      },
      success: function(data) {
        const dados = jQuery.parseJSON(data);
        $('#modalaprovar').modal('hide');
        window.location.reload(); /* Refresh na página para atualizar o pedido na tabela */
      }
    });
  }
}

$(document).ready(function(){
  $('.successBtn').off('click').on('click', function(){
    const row = $(this).closest("tr");
    const idPedidoAusencia = row.attr("idPedido");


    $.ajax({
      url: '../../ausencias/controllers/pedido.cfc?method=ObterPedidoPorIdPedidoAusencia',
      type: 'get',
      data: {
        idPedidoAusencia: idPedidoAusencia
      }, //FALTA TARTAR O ERRO...
      error: function(xhr, status, error) {
        const err = eval('(' + xhr.responseText + ')');
        console.log(xhr);
      },
      success: function(data) {
        const dados = jQuery.parseJSON(data).DATA;
        $("#modalNome").val(dados.NOME_COMPLETO); 
        $("#idPedidoAusenciaModal").val(dados.ID_PEDIDO_AUSENCIA); 
        $("#modalDataInicio").val(new Date(dados.DATAINICIO).toLocaleDateString('en-CA'));
        $("#modalDataFim").val(new Date(dados.DATAFIM).toLocaleDateString('en-CA')); 
        $("#modalFalta").val(dados.TIPO_AUSENCIA); 
        $("#modalRazao").val(dados.COMENTARIO); 
        $("#estadoModal").val(dados.ID_ESTADO);
        /* console.log(data); */

        const dataInicio = $("#modalDataInicio").val();
        const dataFim = $("#modalDataFim").val();

        const dias = calcularDias(dataInicio, dataFim);
        $("#modalDias").text(dias + " dia(s)");
      }
    });
  });


 $('#logout').on('click', function(){
    $.ajax({
      url: '../../ausencias/controllers/pedido.cfc?method=logout',
      type: 'get',
      data: {
      }, 
      error: function(xhr, status, error) {
        const err = eval('(' + xhr.responseText + ')');
        console.log(xhr);
      },
      success: function(data) { 
        /* console.log("a") */
        window.location.assign("../index.cfm")
      }
    });
  });
  

});




/* Para acabar a página de pedidos falta:
  - Ser possivel fazer download do arquivo (adicionar esse botão em todos os estados);
  - Mudar as cores da paginação;
  - Se o utilizador for diretor do departamento x só consegue ver pedidos do seu departamento, se for dos recursos humanos, consegue ver tudo;
  - */


