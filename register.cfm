<cfparam name="errorMessage" default="" />

<cfif structKeyExists(form, "register")>
	<cfif form.password NEQ form.password_confirmation>
		<cfset errorMessage = "Password and Password Confirmation must match." />
	<cfelse>
		<cftry>
			<cfset user_id = createObject("component", "cfcs.Users").createUser(form.email, form.password) />

			<cfset session.user_id = user_id />

			<cflocation url="/" addtoken="false" />

			<cfcatch>
				<cfset errorMessage = "Could not create the user." />
			</cfcatch>
		</cftry>
	</cfif>

</cfif>

<cfoutput>
	<h1>Register</h1>

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
			<label for="password_confirmation" class="control-label">Password Confirmation</label>
			<input type="password" id="password_confirmation" name="password_confirmation" class="form-control" />
		</div>
		<div class="form-group">
			<button name="register" type="submit" class="btn btn-default">Register</button>
		</div>
	</form>
</cfoutput>