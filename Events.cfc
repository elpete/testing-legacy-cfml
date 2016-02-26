<cfcomponent>

	<cffunction name="getAllEvents">
		<cfquery name="events">
			SELECT * FROM events
		</cfquery>

		<cfreturn events />
	</cffunction>

	<cffunction name="createEvent">
		<cfargument name="name" />
		<cfargument name="date" />

		<cfquery>
			INSERT INTO events (name, event_date) VALUES (<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" />, <cfqueryparam value="#arguments.date#" cfsqltype="cf_sql_timestamp" />)
		</cfquery>

		<cfreturn />
	</cffunction>

</cfcomponent>