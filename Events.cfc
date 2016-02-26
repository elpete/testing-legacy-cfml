<cfcomponent>

	<cffunction name="getAllEvents">
		<cfquery name="events">
			SELECT *
			  FROM events
		</cfquery>

		<cfreturn events />
	</cffunction>

</cfcomponent>