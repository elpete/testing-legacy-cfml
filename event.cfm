<cfparam name="errorMessage" default="" />

<cfif NOT structKeyExists(session, "user_id")>
	<cflocation url="/" addtoken="false" />
</cfif>

<cfif structKeyExists(form, "create")>
	<cfif NOT structKeyExists(form, "name") OR form.name EQ "">
		<cfset errorMessage = "Must provide an event name." />
	<cfelseif NOT structKeyExists(form, "date") OR form.date EQ "">
		<cfset errorMessage = "Must provide an event date." />
	<cfelse>
		<cfset event_id = createObject("component", "cfcs.Events").createEvent(form.name, form.date) />
		
		<cflocation url="/view-event.cfm?event=#event_id#" addtoken="false" />
	</cfif>
</cfif>

<cfoutput>
	<h1>Create an Event</h1>

	<cfif errorMessage NEQ "">
		<p class="alert alert-danger">#errorMessage#</p>
	</cfif>

	<form method="POST" action="#CGI.SCRIPT_NAME#">
		<div class="form-group">
			<label for="name" class="control-label">Event Name</label>
			<input type="name" id="name" name="name" class="form-control" />
		</div>
		<div class="form-group">
			<label for="date" class="control-label">Event Date</label>
			<input type="text" id="date" name="date" class="form-control" />
		</div>
		<div class="form-group">
			<button type="submit" name="create" class="btn btn-default">Create Event</button>
		</div>
	</form>
</cfoutput>

<script>
	$("#date").datepicker();
</script>