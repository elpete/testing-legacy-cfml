<cfoutput>
	<cfif NOT structKeyExists(session, "user_id")>
		<cflocation url="/" addtoken="false" />
	</cfif>

	<cfif structKeyExists(form, "invite")>
		<cfset createObject("component", "cfcs.RSVP").sendInvite(form.event_id, form.invite_email) />
		<cflocation url="/view-event.cfm?event=#form.event_id#" addtoken="false" />
	</cfif>

	<cfif structKeyExists(form, "resend")>
		<cfset createObject("component", "cfcs.RSVP").resendInvite(form.rsvp_id) />
		<cflocation url="/view-event.cfm?event=#form.event_id#" addtoken="false" />
	</cfif>

	<cfif NOT structKeyExists(url, "event")>
		<h1>Look up Event</h1>
		<form method="GET" action="#CGI.SCRIPT_NAME#">
			<div class="form-group">
				<label for="event" class="control-label">Event Id</label>
				<input type="event" id="event" name="event" class="form-control" />
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-default">Look Up Event</button>
			</div>
		</form>
	<cfelse>
		<cfset event = createObject("component", "cfcs.Events").findEventById(url.event) />

		<cfif event.RecordCount EQ 0>
			<h1>Look up Event</h1>
			<form method="GET" action="#CGI.SCRIPT_NAME#">
				<div class="form-group">
					<label for="event" class="control-label">Event Id</label>
					<input type="event" id="event" name="event" class="form-control" />
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-default">Look Up Event</button>
				</div>
			</form>
		<cfelse>
			<h3>#event.name# <small class="text-center">#DateFormat(event.event_date, "MMMM D, YYYY")#</small></h3>

			<hr />
	
			<div class="row text-center">
				<form method="POST" action="#CGI.SCRIPT_NAME#" class="form-inline">
					<div class="form-group">
						<input type="hidden" name="event_id" value="#url.event#" />
						<input type="invite_email" id="invite_email" name="invite_email" class="form-control" placeholder="Email" autofocus />
					</div>
					<div class="form-group">
						<button name="invite" type="submit" class="btn btn-primary">Send Invite</button>
					</div>
				</form>
			</div>

			<br /><br />

			<cfset rsvps = createObject("component", "cfcs.RSVP").findRSVPsForEvent(url.event) />
			<cfset RSVPCounts = createObject("component", "cfcs.RSVP").getRSVPCountsForEvent(url.event) />

			<div class="row">
				<div class="col-md-offset-2 col-md-8">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="text-center">
									<a id="pending-filter" href="##">Pending</a>
								</th>
								<th class="text-center">
									<a id="coming-filter" href="##">Coming</a>
								</th>
								<th class="text-center">
									<a id="notcoming-filter" href="##">Not Coming</a>
								</th>
								<th class="text-center">
									<a id="total-filter" href="##">Total</a>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">#RSVPCounts.pending_count#</td>
								<td class="text-center">#RSVPCounts.accepted_count#</td>
								<td class="text-center">#RSVPCounts.rejected_count#</td>
								<td class="text-center">#RSVPCounts.total_count#</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div class="row">
				<table id="rsvps-table" class="table table-hover">
					<thead>
						<tr>
							<th>Email</th>
							<th>RSVP</th>
							<th style="width: 15%;">Respond</th>
							<th style="width: 10%;"></th>
						</tr>
					</thead>
					<tbody>
						<cfloop query="rsvps">
							<tr class="rsvp-row">
								<td>#rsvps.email#</td>
								<td>#rsvps.rsvp#</td>
								<td>
									<div class="btn-group">
										<a class="btn btn-sm btn-success" href="/rsvp.cfm?rsvp_id=#rsvps.id#&amp;rsvp=Accepted">Coming</a>
										<a class="btn btn-sm btn-danger" href="/rsvp.cfm?rsvp_id=#rsvps.id#&amp;rsvp=Rejected">Not Coming</a>
									</div>
								</td>
								<td>
									<form class="resend-form" method="POST" action="#CGI.SCRIPT_NAME#">
										<input type="hidden" name="rsvp_id" value="#rsvps.id#" />
										<button type="submit" name="resend" class="btn btn-sm btn-default">Resend</button>
									</form>
								</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</div>
		</cfif>
	</cfif>
</cfoutput>

<script>
$(document).ready(function() {
	$('.resend-form').on('submit', function(e) {
		e.preventDefault();
		var id = $(this).find('[name=rsvp_id]').val();
		$.ajax({
			url: '/cfcs/RSVP.cfc?method=resendInvite',
			data: {
				id: id
			},
			dataType: 'json'
		})
			.done(function onSuccess(email) {
				alert('Invitation to ' + email + ' re-sent!');
			})
			.fail(function onError(err) {
				console.error(err);
			});
	});

	$('#pending-filter').on('click', function(e) {
		e.preventDefault();
		$('#rsvps-table tbody tr').each(function(index, row) {
			var rowEl = $(row);
			rowEl.show();
			var type = rowEl.children('td')[1].innerHTML;
			if (type !== 'Pending') {
				rowEl.hide();
			}
		});
	});

	$('#coming-filter').on('click', function(e) {
		e.preventDefault();
		$('#rsvps-table tbody tr').each(function(index, row) {
			var rowEl = $(row);
			rowEl.show();
			var type = rowEl.children('td')[1].innerHTML;
			if (type !== 'Accepted') {
				rowEl.hide();
			}
		});
	});

	$('#notcoming-filter').on('click', function(e) {
		e.preventDefault();
		$('#rsvps-table tbody tr').each(function(index, row) {
			var rowEl = $(row);
			rowEl.show();
			var type = rowEl.children('td')[1].innerHTML;
			if (type !== 'Rejected') {
				rowEl.hide();
			}
		});
	});

	$('#total-filter').on('click', function(e) {
		e.preventDefault();
		$('#rsvps-table tbody tr').each(function(index, row) {
			$(row).show();
		});
	});
});
</script>