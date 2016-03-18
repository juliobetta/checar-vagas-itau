require "./lib/crawler.rb"
require "./lib/email_client.rb"

namespace :crawler do
  desc "Notificação de vagas de emprego no Itau"
  task :run, [:cities, :email] do |t, args|
    collector = Crawler.new

    collector.check_jobs_in(args[:cities])
             .then_notify(EmailClient.new({to: args[:email]}))
  end
end
