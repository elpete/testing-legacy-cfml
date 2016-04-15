<cfcomponent>

	<cffunction name="getRSVPById">
		<cfargument name="id" />

		<cfquery name="RSVP">
			SELECT *
			FROM rsvps
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfreturn RSVP />
	</cffunction>

	<cffunction name="getRSVPCountsForEvent">
		<cfargument name="id" />

		<cfquery name="RSVPCounts">
			SELECT
				IFNULL(SUM(CASE WHEN rsvp = "Pending" THEN 1 ELSE 0 END), 0) AS pending_count,
				IFNULL(SUM(CASE WHEN rsvp = "Accepted" THEN 1 ELSE 0 END), 0) AS accepted_count,
				IFNULL(SUM(CASE WHEN rsvp = "Rejected" THEN 1 ELSE 0 END), 0) AS rejected_count,
				IFNULL(COUNT(rsvp), 0) AS total_count
			FROM rsvps
			WHERE event_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_numeric" />
		</cfquery>

		<cfreturn RSVPCounts />
	</cffunction>

	<cffunction name="findRSVPsForEvent">
		<cfargument name="id" />

		<cfquery name="RSVPs">
			SELECT * FROM rsvps
			WHERE event_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_numeric" />
		</cfquery>

		<cfreturn RSVPs />
	</cffunction>

	<cffunction name="sendInvite">
		<cfargument name="event_id" />
		<cfargument name="email" />

		<cfquery>
			INSERT INTO rsvps (id, email, event_id, rsvp)
			VALUES (
				<cfqueryparam value="#createUUID()#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#arguments.event_id#" cfsqltype="cf_sql_integer" />,
				'Pending'
			)
		</cfquery>

		<!--- email logic here --->

		<cfreturn />
	</cffunction>

	<cffunction name="resendInvite" access="remote" returnformat="json">
		<cfargument name="id" />

		<cfset rsvpQuery = getRSVPById(arguments.id) />

		<!--- email logic here --->

		<cfreturn rsvpQuery.email />
	</cffunction>

	<cffunction name="respondToInvitation">
		<cfargument name="id" />
		<cfargument name="rsvp" />

		<cfquery>
			UPDATE rsvps
			SET rsvp = <cfqueryparam value="#arguments.rsvp#" cfsqltype="cf_sql_varchar" />
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfreturn />
	</cffunction>

</cfcomponent>