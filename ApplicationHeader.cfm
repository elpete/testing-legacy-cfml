<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Event Planning — A Legacy Testing Workshop</title>
        <meta name="description" content="This app is intended to show testing concepts applied to a legacy CFML application.">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-default">
          <div class="container-fluid">
            <div class="navbar-header">
              <a class="navbar-brand" href="/">
                Event Planning
              </a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <cfif NOT structKeyExists(session, "user_id")>
                    <li><a href="/register.cfm">Register</a></li>
                    <li><a href="/login.cfm">Log In</a></li>
                <cfelse>
                    <li><a href="/logout.cfm">Log Out</a></li>
                </cfif>
            </ul>
          </div>
        </nav>

        <div id="app-container" class="container">
