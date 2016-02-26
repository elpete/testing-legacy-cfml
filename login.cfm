<cfparam name="errorMessage" default="" />

<cfif structKeyExists(form, "login")>
	<cfset user_id = createObject("component", "cfcs.Users").findUserByEmailAndPassword(form.email, form.password) />

	<cfif user_id NEQ 0>
		<cfset session.user_id = user_id />

		<cflocation url="/" addtoken="false" />
	</cfif>

	<cfset errorMessage = "Invalid credentials." />
</cfif>

<cfoutput>
	<h1>Log In</h1>

	<cfif errorMessage NEQ "">
		<p class="alert alert-danger">#errorMessage#</p>
	</cfif>

	<form method="POST" action="#CGI.SCRIPT_NAME#">
		<div class="form-group">
			<label for="email" class="control-label">Email</label>
			<input type="email" id="email" name="email" class="form-control" />
		</div>
		<div class="form-group">
			<label for="password" class="control-label">Password</label>
			<input type="password" id="password" name="password" class="form-control" />
		</div>
		<div class="form-group">
			<button name="login" type="submit" class="btn btn-default">Log In</button>
		</div>
	</form>
</cfoutput>