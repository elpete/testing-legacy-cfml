<cfcomponent>

	<cffunction name="getAllEventsByUserId">
		<cfargument name="user_id" />

		<cfquery name="events">
			SELECT *
			FROM events
			WHERE created_by_user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfreturn events />
	</cffunction>

	<cffunction name="createEvent">
		<cfargument name="name" />
		<cfargument name="date" />

		<cfquery result="eventQuery">
			INSERT INTO events (name, event_date, created_by_user_id) VALUES (<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" />, <cfqueryparam value="#arguments.date#" cfsqltype="cf_sql_timestamp" />, <cfqueryparam value="#session.user_id#" cfsqltype="cf_sql_integer" />)
		</cfquery>

		<cfreturn eventQuery.generatedKey />
	</cffunction>

	<cffunction name="findEventById">
		<cfargument name="id" />

		<cfquery name="event">
			SELECT * FROM events WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_numeric" />
		</cfquery>

		<cfreturn event />
	</cffunction>

</cfcomponent>