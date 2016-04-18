component extends='testbox.system.BaseSpec' {
    function beforeAll() {}

    function afterAll() {}

    function run() {
        describe('FlashMessage.cfc', function() {
            beforeEach(function() {
                variables.CUT = new cfcs.FlashMessage();
            });

            it('persists a flash message to the session storage', function() {
                CUT.message('::test message::');
                expect(CUT.getMessages()).toHaveLength(1, 'One message should be returned.');
                expect(CUT.getMessages()[1]).toBe('::test message::');
            });

            it('can persist multiple flash messages', function() {
                CUT.message('::test message one::');
                CUT.message('::test message two::');
                expect(CUT.getMessages()).toHaveLength(2, 'Two messages should be returned.');
                expect(CUT.getMessages()[1]).toBe('::test message one::');
                expect(CUT.getMessages()[2]).toBe('::test message two::');
            });

            describe('rendering flash messages', function() {
                it('can render zero messages', function() {
                    var output = CUT.render();
                    var trimmedOutput = Trim(REReplace(output, "\s{2,}", " ", "all" ));
                    expect(trimmedOutput).toBe('');
                });

                it('can render one messages', function() {
                    CUT.message('::test message::');
                    var output = CUT.render();
                    var trimmedOutput = Trim(REReplace(output, "\s{2,}", " ", "all" ));
                    expect(trimmedOutput).toBe('<div class="flash-messages"> <div class="alert alert-info"> <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button> ::test message:: </div> </div>');
                });

                it('can render several messages', function() {
                    CUT.message('::test message one::');
                    CUT.message('::test message two::');
                    var output = CUT.render();
                    var trimmedOutput = Trim(REReplace(output, "\s{2,}", " ", "all" ));
                    expect(trimmedOutput).toBe('<div class="flash-messages"> <div class="alert alert-info"> <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button> ::test message one:: </div> <div class="alert alert-info"> <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button> ::test message two:: </div> </div>');
                });

                it('can clears out the messages after render', function() {
                    CUT.message('::test message::');
                    var output = CUT.render();
                    expect(CUT.getMessages()).toBeEmpty('Messages should be cleared out after render.');
                });
            });
        });
    }
}