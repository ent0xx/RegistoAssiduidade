<cfif NOT IsDefined("Session.MM_Authenticated")>
  <cflocation url="/index.cfm" addtoken="no">
</cfif>

<!--- <cfoutput >
  Sessão: #Session.MM_Authenticated#
</cfoutput> --->


<!DOCTYPE html>
<html lang="en" class="has-navbar-fixed-top">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!--- Bootstrap CSS --->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

 <!---  <!--- Bootstrap CSS local --->
  <link href="../BootstrapLocal/CSS/bootstrap.min.css" rel="stylesheet" type="text/css" /> --->

  <!--- Bootstrap Icons --->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <!--- CSS da Página --->
  <link href="../assets/CSS/dashboard.css" rel="stylesheet" type="text/css" />
  
  <!--- JQUERY --->
 <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script> 
   
</head>
<body> 

  <cfif NOT isDefined("FORM.tipoAusencia") OR NOT isNumeric(FORM.tipoAusencia)>
  <cfset tipoAusencia = 0>
<cfelse>
  <cfset tipoAusencia = FORM.tipoAusencia>
</cfif>
<cfif NOT isDefined("FORM.dataInicio") OR NOT IsDate(FORM.dataInicio)>
  <cfset dataInicioDate = lsParseDateTime("1950-01-01")>
<cfelse>
  <cfset dataInicioDate = lsParseDateTime(FORM.dataInicio)>
</cfif>

<cfif NOT isDefined("FORM.dataFim") OR NOT IsDate(FORM.dataFim)>
  <cfset dataFimDate = lsParseDateTime("9999-12-31")>
<cfelse>
  <cfset dataFimDate = lsParseDateTime(FORM.dataFim)>
</cfif>
  
  <!--- Nav Bar --->
  <cfinclude template="navbar.cfm">

  <!--- Dashboard  --->
  <main class="mt-2 pt-2">