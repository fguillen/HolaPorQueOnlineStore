# puts "XXX: #{ActionMailer::Base.delivery_method}"

ActionMailer::Base.smtp_settings = {
  :address        => CONFIG[:smtp_server],
  :port           => 25,
  :domain         => CONFIG[:smtp_domain],
  :authentication => :login,
  :user_name      => CONFIG[:smtp_user],
  :password       => CONFIG[:smtp_pass]
}

ActionMailer::Base.raise_delivery_errors = true