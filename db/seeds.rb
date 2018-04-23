unless Operator::User.exists?(nickname: 'admin@miskre')
  Operator::User.create(nickname: 'admin@miskre', password: 'operator@2018', authority: 10)
end

unless Operator::User.find_by(nickname: 'admin@miskre')&.two_factor_auth_secret
  two_factor_auth_secret = ROTP::Base32.random_base32
  Operator::User.where(nickname: 'admin@miskre').update_all(use_two_factor_auth: false, two_factor_auth_secret: two_factor_auth_secret)
  puts "admin@miskre two factor secret: #{two_factor_auth_secret}"
end

Operator::MailContent.kinds.keys
.select{|key| !Operator::MailContent.exists?(kind: Operator::MailContent.kinds[key])}
.each do |key|
  Operator::MailContent.create(
    kind: key,
    subject: key.humanize,
    body: File.open(Rails.root+"db"+"mailseeds"+(key.to_s+".txt")).read
  )
  puts "created #{key} mail content"
end