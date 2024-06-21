$(document).ready(function() {
  var fidFuncionario = $('#FID_funcionario').val(); /* Este valor tem que estar definido antes de iniciar o calendario  */
  initializeCalendar(fidFuncionario);
});

function initializeCalendar(fidFuncionario) {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    locale: 'pt',
    events: function(fetchInfo, successCallback, failureCallback) {
      $.ajax({
        url: '../../ausencias/controllers/agenda.cfc?method=getPedidosCalendario',
        type: 'GET',
        dataType: 'json',
        data: {
          FID_funcionario: fidFuncionario
        },
        success: function(data) {
          var events = $.map(data, function(event) {
            return {
              title: event.title,
              start: new Date(event.start).toISOString(),
              end: new Date(event.end).toISOString(),
            };
          });
          successCallback(events);
        },
        error: function(jqXHR, textStatus, errorThrown) {
          failureCallback(errorThrown);
        }
      });
    }
  });
  calendar.render();
}