<cfcomponent>
	<cffunction name="createUser">
		<cfargument name="email" />
		<cfargument name="password" />

		<cfquery result="createUserQuery" >
			INSERT INTO users (email, password) VALUES (<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" />, <cfqueryparam value="#Hash(arguments.password)#" cfsqltype="cf_sql_varchar" />)
		</cfquery>

		<cfreturn createUserQuery.generatedKey />
	</cffunction>

	<cffunction name="findUserByEmailAndPassword">
		<cfargument name="email" />
		<cfargument name="password" />

		<cfquery name="findUserQuery" >
			SELECT * FROM users WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" /> AND password = <cfqueryparam value="#Hash(arguments.password)#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfif findUserQuery.RecordCount NEQ 0 >
			<cfreturn findUserQuery.id />
		</cfif>

		<cfreturn 0 />
	</cffunction>
</cfcomponent>