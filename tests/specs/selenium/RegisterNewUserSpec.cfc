component extends='cfselenium.BaseSpec' {
    function beforeAll() {
        super.beforeAll('http://#CGI.HTTP_HOST#');
    }

    function afterAll() {
        super.afterAll();
    }

    /**
    * @afterEach
    */
    function cleanUpDatabase() {
        queryExecute("DELETE FROM users WHERE email = 'bob@example.com'");
    }

    function run() {
        feature('Registering for the site', function() {
            scenario('A new user registering successfully for the site', function() {
                given('I go to the home page and I do not have an account', function() {
                    when('I click register, fill in the form, and click `Register`', function() {
                        then('I should be logged in and see my Events dashboard', function() {
                            selenium.open('/');
                            expect(selenium.getTitle()).toBe('Event Planning — A Legacy Testing Workshop');
                            selenium.click('link=Register');
                            selenium.waitForPageToLoad('2000');
                            expect(selenium.isTextPresent('Register')).toBeTrue();
                            selenium.type('name=email', 'bob@example.com');
                            selenium.type('name=password', 'mY@w3s0m3P2ssw0rD');
                            selenium.type('name=password_confirmation', 'mY@w3s0m3P2ssw0rD');
                            selenium.click('name=register');
                            selenium.waitForPageToLoad('2000');
                            expect(selenium.isTextPresent('Events')).toBeTrue();
                            expect(selenium.isTextPresent('Log Out')).toBeTrue();
                        });
                    });
                });
            });
        });
    }
}