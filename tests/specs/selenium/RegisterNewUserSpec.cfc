component extends='cfselenium.BaseSpec' {
    function beforeAll() {
        super.beforeAll('http://#CGI.HTTP_HOST#');
    }

    function afterAll() {
        super.afterAll();
    }

    function run() {
        feature('Registering for the site', function() {
            scenario('A new user registering successfully for the site', function() {
                given('I go to the home page and I do not have an account', function() {
                    when('I click register, fill in the form, and click `Register`', function() {
                        then('I should be logged in and see my Events dashboard', function() {
                            selenium.open('/');
                            expect(selenium.getTitle()).toBe('Event Planning — A Legacy Testing Worksho');
                        });
                    });
                });
            });
        });
    }
}