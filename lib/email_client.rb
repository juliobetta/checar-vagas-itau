require 'ostruct'
require 'mail'
require 'dotenv'

Dotenv.load

class EmailClient < OpenStruct
  def send(message)
    email = self.to

    mailer = Mail.new do
      from    'xnotifier@email.com'
      to      email
      subject 'Alerta de vaga Itau'

      html_part do
        content_type 'text/html; charset=UTF-8'
        body message
      end
    end

    mailer.delivery_method :smtp, address:   ENV['SMTP_HOST'],
                                  domain:    ENV['SMTP_DOMAIN'],
                                  port:      ENV['SMTP_PORT'],
                                  user_name: ENV['SMTP_USERNAME'],
                                  password:  ENV['SMTP_PASSWORD'],
                                  tls:       ENV['SMTP_TLS_ENABLED']

    mailer.deliver
  end
end
