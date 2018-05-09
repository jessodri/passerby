class AcceptRequestMailer < ApplicationMailer

    def accept_request(user)
        @user = user
        mg_client = Mailgun::Client.new ENV.fetch('MAILGUN_API')
        message_params = { from: ENV.fetch('MAILGUN_EMAIL'),
                           to: @user.email,
                           subject: 'Accepted Request',
                           text: 'You have accepted a new pickup request.'}
        mg_client.send_message ENV.fetch('MAILGUN_DOMAIN'), message_params
    end

end
