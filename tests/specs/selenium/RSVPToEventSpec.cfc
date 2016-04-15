component extends='cfselenium.BaseSpec' {
    function beforeAll() {
        super.beforeAll('http://#CGI.http_host#');
    }

    function afterAll() {
        super.afterAll();
    }

    /**
    * @afterEach
    */
    function cleanUpDatabase() {
        queryExecute("DELETE FROM rsvps WHERE id = '4F7D88C8-CD2B-48CB-B7CC020E9DF720E2'");
    }

    function run() {
        feature('Responding to an invitation', function() {
            scenario('The rsvp id exists', function() {
                given('I go to the RSVP page and have a valid rsvp id', function() {
                    when('I fill in the form and click `RSVP`', function() {
                        then('I should see a notification showing that my RSVP was accepted', function() {
                            var rsvpId = '4F7D88C8-CD2B-48CB-B7CC020E9DF720E2';
                            createRSVP(rsvpId);

                            selenium.open('/rsvp.cfm');
                            expect(selenium.isTextPresent('RSVP')).toBeTrue();
                            selenium.type('name=rsvp_id', rsvpId);
                            selenium.click('identifier=rsvp1');
                            selenium.click('identifier=rsvp-button');
                            selenium.waitForPageToLoad('2000');
                            expect(selenium.getLocation()).toBe('http://#CGI.http_host#/');
                            expect(selenium.isElementPresent('css=.alert')).toBeTrue('Could not find an alert box');
                        });
                    });
                });
            });
        });
    }

    function createRSVP(
        rsvpId = '4F7D88C8-CD2B-48CB-B7CC020E9DF720E2',
        email = 'john@example.com',
        eventId = 1,
        rsvp = 'Pending'
    ) {
        queryExecute('INSERT INTO rsvps VALUES (:rsvpId, :email, :eventId, :rsvp)',
            {
                rsvpId = arguments.rsvpId,
                email = arguments.email,
                eventId = arguments.eventId,
                rsvp = arguments.rsvp
            });
    }
}