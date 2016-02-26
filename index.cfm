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
				<td colspan="3" class="text-center">No Events Yet!</td>
				</tr>
		<cfelse>
			<cfoutput query="allEvents">
				<tr>
					<td>#name#</td>
					<td>#event_date#</td>
					<td>
						<button class="btn btn-default">RSVP</button>
					</td>
				</tr>
			</cfoutput>
		</cfif>
	</tbody>
</table>
