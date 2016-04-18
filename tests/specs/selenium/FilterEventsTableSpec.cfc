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
    function cleanUp() {
        queryExecute("DELETE FROM users WHERE id = :id", { id = variables.userId });
        queryExecute("DELETE FROM events WHERE id = :id", { id = variables.eventId });
        queryExecute("DELETE FROM rsvps WHERE event_id = :id", { id = variables.eventId });

        structDelete(variables, 'userId');
        structDelete(variables, 'eventId');
        structDelete(session, 'user_id');
    }

    /**
    * @afterEach
    */
    function logOutIfNeeded() {
        selenium.open('/');
        if (selenium.isElementPresent('link=Log Out')) {
            selenium.click('link=Log Out');
        }
    }

    function run() {
        feature('Filtering the RSVP Status Table', function() {
            given('I am a registered user and have created an event and sent out invitations', function() {
                beforeEach(function() {
                    variables.userId = createUser();

                    variables.eventId = createEvent(variables.userId);
                    variables.pendingCount = 3;
                    variables.acceptedCount = 2;
                    variables.rejectedCount = 5;
                    createInvitations(
                        eventId = variables.eventId,
                        pendingCount = variables.pendingCount,
                        acceptedCount = variables.acceptedCount,
                        rejectedCount = variables.rejectedCount
                    );

                    logIn();
                    selenium.open('/view-event.cfm?event=#variables.eventId#');
                    selenium.waitForPageToLoad('2000');
                    expect(selenium.getCssCount('.rsvp-row')).toBe(10, '10 rows should be created');
                });

                when('I go to the specific event page', function() {
                    when('I click on `Pending`', function() {
                        then('I should only see the invitations in a status of `Pending`', function() {
                            selenium.click('identifier=pending-filter');
                            var hiddenCount = selenium.getXpathCount('//*[@id="rsvps-table"]/tbody/tr[@style="display: none;"]');
                            var visibleCount = selenium.getCssCount('.rsvp-row') - hiddenCount;
                            expect(visibleCount).toBe(3);
                        });
                    });
                    when('I click on `Coming`', function() {
                        then('I should only see the invitations in a status of `Accepted`', function() {
                            selenium.click('identifier=coming-filter');
                            var hiddenCount = selenium.getXpathCount('//*[@id="rsvps-table"]/tbody/tr[@style="display: none;"]');
                            var visibleCount = selenium.getCssCount('.rsvp-row') - hiddenCount;
                            expect(visibleCount).toBe(2);
                        });
                    });
                    when('I click on `Not Coming`', function() {
                        then('I should only see the invitations in a status of `Rejected`', function() {
                            selenium.click('identifier=notcoming-filter');
                            var hiddenCount = selenium.getXpathCount('//*[@id="rsvps-table"]/tbody/tr[@style="display: none;"]');
                            var visibleCount = selenium.getCssCount('.rsvp-row') - hiddenCount;
                            expect(visibleCount).toBe(5);
                        });
                    });
                    when('I click on `Total` (after clicking on another status)', function() {
                        then('I should see all invitations regardless of their status', function() {
                            selenium.click('identifier=notcoming-filter');
                            selenium.click('identifier=total-filter');
                            var hiddenCount = selenium.getXpathCount('//*[@id="rsvps-table"]/tbody/tr[@style="display: none;"]');
                            var visibleCount = selenium.getCssCount('.rsvp-row') - hiddenCount;
                            expect(visibleCount).toBe(10);
                        });
                    });
                });
            });
        });
    }

    function createUser() {
        queryExecute("INSERT INTO users (email, password) VALUES (:email, :password)", {
            email = 'bob@example.com',
            password = hash('password')
        });

        return queryExecute("SELECT id FROM users WHERE email = :email", {
            email = 'bob@example.com'
        }).id;
    }

    function createEvent(userId) {
        queryExecute("INSERT INTO events (name, event_date, created_by_user_id) VALUES (:name, :eventDate, :userId)", {
            name = 'Test Event',
            eventDate = {
                value = CreateDate(2020, 01, 01),
                cfsqltype = "CF_SQL_DATE"
            },
            userId = arguments.userId
        });

        return queryExecute("SELECT id FROM events WHERE name = 'Test Event' AND created_by_user_id = :userId", {
            name = 'Test Event',
            userId = arguments.userId
        }).id;
    }

    function createInvitations(
        required numeric eventId,
        numeric pendingCount = 1,
        numeric acceptedCount = 1,
        numeric rejectedCount = 1
    ) {

        while(arguments.pendingCount > 0) {
            var id = createUUID();
            var email = id & '@example.com';
            queryExecute("INSERT INTO rsvps VALUES (:id, :email, :eventId, :status)", {
                id = id,
                email = email,
                eventId = arguments.eventId,
                status = 'Pending'
            });
            arguments.pendingCount--;
        }

        while(arguments.acceptedCount > 0) {
            var id = createUUID();
            var email = id & '@example.com';
            queryExecute("INSERT INTO rsvps VALUES (:id, :email, :eventId, :status)", {
                id = id,
                email = email,
                eventId = arguments.eventId,
                status = 'Accepted'
            });
            arguments.acceptedCount--;
        }

        while(arguments.rejectedCount > 0) {
            var id = createUUID();
            var email = id & '@example.com';
            queryExecute("INSERT INTO rsvps VALUES (:id, :email, :eventId, :status)", {
                id = id,
                email = email,
                eventId = arguments.eventId,
                status = 'Rejected'
            });
            arguments.rejectedCount--;
        }

        return;
    }

    function logIn() {
        selenium.open('/login.cfm');
        selenium.waitForPageToLoad('2000');
        selenium.type('name=email', 'bob@example.com');
        selenium.type('name=password', 'password');
        selenium.click('login');
    }


}