$(document).ready(function() {
  const rowsPerPage = 7;
  const rows = $('#table tbody tr');
  const rowsCount = rows.length;
  const pageCount = Math.ceil(rowsCount / rowsPerPage);
  const pagination = $('.pagination');
  const rangeSpan = 2; 
  let currentPage = loadCurrentPage(); 


  function saveCurrentPage() {
    localStorage.setItem('currentPage', currentPage);
  }

  function loadCurrentPage() {
    const savedPage = parseInt(localStorage.getItem('currentPage'));
    return !isNaN(savedPage) ? savedPage : 1; 
  }

  function displayPage(page) {
    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    rows.hide();
    rows.slice(start, end).show();
  }

  function setupPagination() {
    pagination.find('.page-number').remove();

    let startPage = Math.max(currentPage - rangeSpan, 1);
    let endPage = Math.min(currentPage + rangeSpan, pageCount);

    for (let i = startPage; i <= endPage; i++) {
      const pageNumberElement = $('<li class="page-item page-number"></li>').toggleClass('active', i === currentPage);
      const pageLink = $('<a class="page-link" href="#"></a>').text(i).on('click', function(e) {
        e.preventDefault();
        currentPage = i;
        displayPage(currentPage);
        setupPagination();
        saveCurrentPage();
      });

      pageLink.appendTo(pageNumberElement);
      pageNumberElement.insertBefore(pagination.find('#last').parent());
    }
  }

  $('#first').on('click', function(e) {
    e.preventDefault();
    if (currentPage !== 1) {
      currentPage = 1;
      displayPage(currentPage);
      setupPagination();
      saveCurrentPage();
    }
  });

  $('#last').on('click', function(e) {
    e.preventDefault();
    if (currentPage !== pageCount) {
      currentPage = pageCount;
      displayPage(currentPage);
      setupPagination();
      saveCurrentPage();
    }
  });

  displayPage(currentPage);
  setupPagination();
});