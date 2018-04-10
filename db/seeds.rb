unless Operator::User.exists?(nickname: 'huytp@miskre')
  Operator::User.create(nickname: 'huytp@miskre', password: 'miskre@20189999', authority: 10)
end

unless Operator::User.find_by(nickname: 'huytp@miskre')&.two_factor_auth_secret
  two_factor_auth_secret = ROTP::Base32.random_base32
  Operator::User.where(nickname: 'huytp@miskre').update_all(use_two_factor_auth: false, two_factor_auth_secret: two_factor_auth_secret)
  puts "huytp@miskre two factor secret: #{two_factor_auth_secret}"
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