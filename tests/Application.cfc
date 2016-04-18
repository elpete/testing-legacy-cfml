component {

    this.name = 'TestBoxTestingSuite' & hash(getCurrentTemplatePath());
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 15, 0);
    this.applicationTimeout = createTimeSpan(0, 0, 15, 0);
    this.setClientCookies = true;

    this.mappings['/tests'] = getDirectoryFromPath(getCurrentTemplatePath());
    rootPath = REReplaceNoCase(this.mappings['/tests'], 'tests(\\|/)', '');
    this.mappings['/root'] = rootPath;

    this.datasources['eventplanning'] = {
        class: 'org.gjt.mm.mysql.Driver',
        connectionString: 'jdbc:mysql://localhost:3306/eventplanning?user=root&useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
    };
    this.datasource = 'eventplanning';

    function onApplicationStart() {
        application.flashMessage = new root.cfcs.FlashMessage();
    }
}