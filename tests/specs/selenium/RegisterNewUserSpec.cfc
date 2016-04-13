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

            scenario('Trying to register a new user with the same email', function() {
                given('I have previously registered', function() {
                    when('When I go to register, fill in the form, and click `Register`', function() {
                        then('I should see an error message', function() {
                            var email = 'bob@example.com';
                            createUser(email);

                            selenium.open('/register.cfm');
                            expect(selenium.getTitle()).toBe('Event Planning — A Legacy Testing Workshop');
                            expect(selenium.isTextPresent('Register')).toBeTrue();
                            selenium.type('name=email', email);
                            selenium.type('name=password', 'mY@w3s0m3P2ssw0rD');
                            selenium.type('name=password_confirmation', 'mY@w3s0m3P2ssw0rD');
                            selenium.click('name=register');
                            selenium.waitForPageToLoad('2000');
                            expect(selenium.isTextPresent('Log Out')).toBeFalse('We seem to still be logged in');
                            expect(selenium.isElementPresent('css=.alert')).toBeTrue('Could not find an alert box');
                        });
                    });
                });
            });
        });
    }

    function createUser(email = 'joe@example.com', password = 'does not matter') {
        queryExecute("INSERT INTO users (email, password) VALUES (:email, :password)",
            {
                email = arguments.email,
                password = hash(arguments.password)
            }
        );
    }
}