component {
    property name="messages";

    function init() {
        variables.messages = [];
    }

    function message(text) {
        messages.append(text);
    }

    function getMessages() {
        return messages;
    }

    private function clearMessages() {
        messages = [];
        return;
    }

    function render() {
        local.messages = getMessages()
        clearMessages();

        if (messages.len() == 0) {
            return '';
        }

        return ['<div class="flash-messages">',
            local.messages.map(function(message) {
                return '
                    <div class="alert alert-info">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        #message#
                    </div>
                ';
            }).toList(' '),
            '</div>'].toList(' ');
    }
}