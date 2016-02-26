<cfcomponent>

	<cfset this.datasources["eventplanning"] = {
		class: 'org.gjt.mm.mysql.Driver',
		connectionString: 'jdbc:mysql://localhost:3306/eventplanning?user=root&useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
		} />
	<cfset this.datasource = "eventplanning" />

	<cffunction name="onRequestStart">
		<cfargument name="targetPage" />

		<cfinclude template="ApplicationHeader.cfm" />
	</cffunction>

	<cffunction name="onRequestEnd">
		<cfargument name="targetPage" />

		<cfinclude template="ApplicationFooter.cfm" />
	</cffunction>

</cfcomponent>