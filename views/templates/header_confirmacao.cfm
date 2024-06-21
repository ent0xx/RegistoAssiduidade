<cfif NOT IsDefined("Session.MM_Authenticated")>
  <cflocation url="/index.cfm" addtoken="no">
</cfif>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!--Bootstrap CSS-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <!--Bootstrap Icons-->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <link href="../assets/CSS/index.css" rel="stylesheet" type="text/css"/>

</head>

<body>
  
 <!--NavBar-->
 <section class="hero is-warning">
   <div class="hero-head">
     <nav class="navbar">
       <div class="container">
         <div class="navbar-brand">
           <a class="navbar-item">
             <img src="../assets/images/logo_ias_full.png" alt="Logo">
           </a>
         </div>
       </div>
     </nav>
   </div>
 </section>