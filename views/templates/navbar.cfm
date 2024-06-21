<link href="../assets/CSS/navbar_dashboard.css" rel="stylesheet" type="text/css"/>

<!--- NavBar (top) --->
<nav class="navbar shadow navbar-expand-lg navbar-dark fixed-top">
  <div class="container-fluid">
    <button type="button" class="navbar-toggler" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="offcanvasExample">
      <span class="navbar-toggler-icon" data-bs-target="#sidebar"></span>
    </button>
    <div class="collapse navbar-collapse" id="topNavBar">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="agenda.cfm">Agenda</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="pedidos.cfm">Pedidos</a>
        </li>
        <cfif Session.MM_NivelAcesso NEQ "Administrador">
          <!--- Se não for Admin (e talvez se não tiver admin mas permissoes para ver) não mostrar --->
        <cfelse>
          <li class="nav-item dropdown"> <!--- Desabilitar as duas páginas por agora --->
            <a class="nav-link dropdown-toggle ms-2" role="button" href="#" data-bs-toggle="dropdown" aria-expanded="false"> Gestão </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="gestao_utilizadores.cfm">Utilizadores</a></li>
              <li><a class="dropdown-item" href="gestao_politica.cfm">Política</a></li>
            </ul>
        </li> 
        </cfif>
      </ul>
    </div>
    <ul class="navbar-nav ms-auto align-items-center">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="notificationDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-bell-fill"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown">
          <li><a class="dropdown-item" href="#">Notificação 1</a></li>
        </ul>
      </li>
      <li class="nav-item">
        <!--- <a class="nav-link" id="logout"> --->
          <a class="nav-link logout" id="logout">
          <i class="bi bi-box-arrow-right"></i>
        </a>
      </li>
    </ul>
  </div>
</nav>

<script src="../assets/scripts/modal_pedidos.js"></script>

<!--- Class, ultimo "logout" tem que ser o pessoal, o primeiro é o do plugin (Bootstrap) --->