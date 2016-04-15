<cfcomponent>

	<cfset this.datasources["eventplanning"] = {
		class: 'org.gjt.mm.mysql.Driver',
		connectionString: 'jdbc:mysql://localhost:3306/eventplanning?user=root&useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
		} />
	<cfset this.datasource = "eventplanning" />

	<cffunction name="onRequestStart">
		<cfargument name="targetPage" />

		<cfif listLast(arguments.targetPage, ".") NEQ "cfc">
			<cfinclude template="ApplicationHeader.cfm" />
		</cfif>
	</cffunction>

	<cffunction name="onRequestEnd">
		<cfargument name="targetPage" />

		<cfif listLast(arguments.targetPage, ".") NEQ "cfc">
			<cfinclude template="ApplicationFooter.cfm" />
		</cfif>
	</cffunction>

</cfcomponent>