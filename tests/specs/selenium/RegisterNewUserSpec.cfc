component extends='cfselenium.BaseSpec' {
    function beforeAll() {
        super.beforeAll('http://#CGI.http_host#');
    }

    function afterAll() {
        super.afterAll();
    }

    function run() {

    }
}