if Rails.env.production?
  # ActionMailer::Base.delivery_method = :smtp
  # ActionMailer::Base.smtp_settings = {
  #   address: 'smtp.gmail.com',
  #   domain: 'gmail.com',
  #   port: 587,
  #   user_name: Rails.application.credentials[:mail][:user_name],
  #   password: Rails.application.credentials[:mail][:password],
  #   authentication: 'plain',
  #   enable_starttls_auto: true
  # }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  :user_name => '21045c50cef646',
  :password => 'e243ded583d040',
  :address => 'smtp.mailtrap.io',
  :domain => 'smtp.mailtrap.io',
  :port => '2525',
  :authentication => :cram_md5
}
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
else
  ActionMailer::Base.delivery_method = :test
end