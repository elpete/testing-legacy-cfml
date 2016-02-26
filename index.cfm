<cfoutput>
	<cfset allEvents = createObject('component', 'Events').getAllEvents() />

	<h1 class="text-center">Events</h1>

	<table class="table table-hover">
		<thead>
			<tr>
				<th style="width: 60%;">Event Name</th>
				<th>Event Date</th>
				<th>RSVP</th>
			</tr>
		</thead>
		<tbody>
			<cfif allEvents.RecordCount EQ 0>
				<tr>
					<td colspan="3" class="text-center">
						No Events Yet!
						<br />
						<cfif NOT structKeyExists(session, "user_id")>
							<a href="/login.cfm">Log In</a> to create one now!
						<cfelse>
							<a href="/event.cfm">Create one now!</a>
						</cfif>
					</td>
				</tr>
			<cfelse>
				<cfloop query="allEvents">
					<tr>
						<td>#name#</td>
						<td>#DateFormat(event_date, 'DD MMM YYYY')#</td>
						<td>
							<button class="btn btn-sm btn-default">RSVP</button>
						</td>
					</tr>
				</cfloop>
			</cfif>
		</tbody>
	</table>
</cfoutput>