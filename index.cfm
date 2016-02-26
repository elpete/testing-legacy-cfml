<cfoutput>
	<cfif NOT structKeyExists(session, "user_id")>

		<div class="text-center">
			<h4><a href="/rsvp.cfm">Click Here</a> to RSVP to an Event,</h4>
			<h4><a href="/login.cfm">Log In</a> to manage your Events,</h4>
			<h4>or <a href="/register.cfm">Register</a> to start creating your own Events</h4>
			
		</div>
	<cfelse>
		<cfset allEvents = createObject('component', 'Events').getAllEvents() />

		<h1 class="text-center">Events</h1>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>Event Name</th>
					<th>Event Date</th>
					<th>Pending</th>
					<th>Coming</th>
					<th>Not Coming</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<cfif allEvents.RecordCount EQ 0>
					<tr>
						<td colspan="6" class="text-center">
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
						<cfset RSVPCounts = createObject("component", "cfcs.RSVP").getRSVPCountsForEvent(allEvents.id) />
						<tr>
							<td><a href="/view-event.cfm?event=#allEvents.id#">#allEvents.name#</a></td>
							<td>#DateFormat(allEvents.event_date, 'MMMM D, YYYY')#</td>
							<td class="text-center">#RSVPCounts.pending_count#</td>
							<td class="text-center">#RSVPCounts.accepted_count#</td>
							<td class="text-center">#RSVPCounts.rejected_count#</td>
							<td>
								<a href="/view-event.cfm?event=#allEvents.id#" class="btn btn-sm btn-default">Send Invites</a>
							</td>
						</tr>
					</cfloop>
				</cfif>
			</tbody>
		</table>
	</cfif>
</cfoutput>