<cfoutput>
	<cfif (NOT structKeyExists(url, "rsvp_id") OR NOT structKeyExists(url, "rsvp")) AND NOT structKeyExists(form, "rsvp_id")>
		<h1>RSVP</h1>
		<form method="POST" action="#CGI.SCRIPT_NAME#">
			<div class="form-group">
				<label for="rsvp_id" class="control-label">RSVP Id</label>
				<input type="rsvp_id" id="rsvp_id" name="rsvp_id" class="form-control" />
			</div>
			<div class="form-group">
				<label for="rsvp" class="control-label">RSVP</label>
				<div class="radio">
				  <label>
				    <input type="radio" name="rsvp" id="rsvp1" value="Accepted" checked>
				    Coming
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="rsvp" id="rsvp2" value="Rejected">
				    Not Coming
				  </label>
				</div>
			</div>
			<div class="form-group">
				<button type="submit" id="rsvp-button" class="btn btn-default">RSVP</button>
			</div>
		</form>
	<cfelse>
		<cfset rsvp_id = structKeyExists(form, "rsvp_id") ? form.rsvp_id : url.rsvp_id />
		<cfset rsvp = structKeyExists(form, "rsvp") ? form.rsvp : url.rsvp />

		<cfset createObject("component", "cfcs.RSVP").respondToInvitation(rsvp_id, rsvp) />
		<cfset rsvp = createObject("component", "cfcs.RSVP").getRSVPById(rsvp_id) />

		<cfset session.messages = ['Sucessfully recorded your RSVP'] />

		<cflocation url="/" addtoken="false" />
	</cfif>
</cfoutput>