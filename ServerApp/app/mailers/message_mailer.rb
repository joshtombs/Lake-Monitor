class MessageMailer < ActionMailer::Base

  default from: "LMS Contact Form <noreplyLMSviall@gmail.com>"
  default to: "LMS Admin <jtombs@umassd.edu>"

  def new_message(message)
    @message = message
    mail subject: "Message from #{message.name}"
  end

  def send_warning(message, recipients)
  	@message = message
	mail(to: recipients, from: "LMS Notifications <noreplyLMSviall@gmail.com>", subject: "Warning! Potentially Dangerous Lake Conditions").deliver
  end
end