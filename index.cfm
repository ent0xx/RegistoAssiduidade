<cfset csrfTokenMsgErro = "">

<cfif NOT isdefined("form.token") OR NOT CSRFVerifyToken(form.token)>
  <cfset csrfTokenMsgErro = "<br>A submissão do formulário é inválida!">
<cfelse>
  <cfif IsDefined("FORM.Utilizador")>
		<cfset MM_redirectLoginFailed="#application.WebRoot#/index.cfm?msg=Fail">

    <cftry>
      <cfset StructDelete(Session, "numeroUtente")>
       <cfinvoke webservice="https://qa-autenticacao.iasaude.pt/controllers/ctrl_autenticacao.cfc?wsdl" method="AutenticaUser" returnvariable="dadosAutenticacao">
        <cfinvokeargument name="username" value="#FORM.Utilizador#">
        <cfinvokeargument name="password" value="#FORM.Passe#">
        <cfinvokeargument name="plataforma" value="Ausencias">
      </cfinvoke>

      <cfcatch type="any">
        <cfset erro="true">
        <cfset detalheErro = CFCATCH>
      </cfcatch>
    </cftry>
		
    <cfif isDefined("dadosAutenticacao") AND dadosAutenticacao.autenticado>
			<cfset MM_redirectLoginSuccess="#application.WebRoot#/views/agenda.cfm">

      <cftry>
        <cflock scope="Session" timeout="30" type="Exclusive">
          <cfset Session.MM_Authenticated = dadosAutenticacao.autenticado>
          <cfset Session.MM_UserID = dadosAutenticacao.idUtilizador>
          <cfset Session.MM_UserName = dadosAutenticacao.nomeCompleto>
          <cfset Session.MM_NivelAcesso = dadosAutenticacao.nivelAcesso>
          <cfset Session.MM_Permissions = dadosAutenticacao.permissoes>
          <cfset session.MM_Email = dadosAutenticacao.email>
        </cflock>        
        <cfif IsDefined("URL.accessdenied") AND true>
          <cfset MM_redirectLoginSuccess=URL.accessdenied>
        </cfif>
        <cflocation url="#MM_redirectLoginSuccess#" addtoken="no">
        <cfcatch type="Lock">
          <!--- code for handling timeout of cflock --->
        </cfcatch>
      </cftry>    
    <cfelse>
      <cftry>
        <cflock scope="Session" timeout="30" type="Exclusive">
          <cfset Session.Feedback = #deserializeJSON(dadosAutenticacao.msg)#>
        </cflock>        
        <cfcatch type="Lock">
          <!--- code for handling timeout of cflock --->
        </cfcatch>
      </cftry>    
      <cflocation url="#application.WebRoot#/index.cfm?msg=ErroFeedback" addtoken="no">    
    </cfif>
    <cflocation url="#MM_redirectLoginFailed#" addtoken="no">
  
  <cfelse>
    <cfset MM_LoginAction=CGI.SCRIPT_NAME>
    <cfif CGI.QUERY_STRING NEQ "">
      <cfset MM_LoginAction=MM_LoginAction & "?" & XMLFormat(CGI.QUERY_STRING)>
    </cfif>
  </cfif>
</cfif>
<!--Header-->
<cfinclude template="views/templates/header_index.cfm">
 
  <!-- Formulário de Login -->
  <div class="accountbg"></div>
    <div class="wrapper-page">
      <div class="shadow-lg card">
        <div class="card-body">
          <img id="profile-img " class="profile-img-card shadow" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
          <div class="p-3">
						<cfoutput>
							<form class="form-horizontal m-t-20" method="post" name="submitButton" id="submitButton" value="Login">
								<input type="hidden" name="token" value="#CSRFGenerateToken()#"> 
								<div class="form-group row mb-3">
									<div class="col-12">
										<input class="form-control shadow-sm" type="text" required="true" placeholder="Nome de Utilizador" id="utilizador" name="utilizador">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-12">
										<input class="form-control shadow-sm" type="password" required="true" placeholder="Palavra-passe" id="passe" name="passe">
									</div>
								</div>
								<div class="form-group text-center row m-t-20">
									<div class="col-12">
										<input name="submitLogin" id="submitLogin" class="btn btn-info btn-block waves-effect waves-light shadow-sm" type="submit" value="Login"/>
									</div>
								</div>
								<cfif isDefined("URL.msg")>
									<cfif URL.msg == "fail">
										<div class="row mb-4 mt-5">
											<div class="col-md-12">
												<div class="alert alert-warning">
													A Autenticação falhou! Tente novamente.<cfoutput>#csrfTokenMsgErro#</cfoutput>
												</div>
											</div>
										</div>
									<cfelse>
										<div class="row mb-4 mt-5">
											<div class="col-md-12">
												<div class="alert alert-warning">
													<cfoutput>#Session.Feedback[1].msg#</cfoutput>
												</div>
											</div>
										</div>
									</cfif>
								</cfif>
							</form>
						</cfoutput>
          </div>
        </div>
      </div>
    </div>
  </div>

</body>
</html>