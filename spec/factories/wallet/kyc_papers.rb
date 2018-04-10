include ActionDispatch::TestProcess

def locale_us
  Faker::Config.locale = "en-US"
  return yield
ensure
  Faker::Config.locale = I18n.default_locale
end

FactoryGirl.define do
  factory :wallet_kyc_paper, class: Wallet::PassportKycPaper do
    country "JA"
    first_name       { locale_us{ Faker::Name.first_name } }
    last_name        { locale_us{ Faker::Name.last_name } }
    first_name_kanji { Faker::Name.first_name }
    last_name_kanji  { Faker::Name.last_name }
    birth_date       { Faker::Date.between(80.years.ago, 10.years.ago) }
    street           { Faker::Address.street_name }
    city             { Faker::Address.city }
    region           { Faker::Address.state }
    postal_code      { Faker::Address.postcode }
    tel              { Faker::PhoneNumber.phone_number }
    face_and_passport                { fixture_file_upload("#{Rails.root}/spec/fixtures/images/license.jpg", "image/jpg") }
    passport                         { fixture_file_upload("#{Rails.root}/spec/fixtures/images/license.jpg", "image/jpg") }
    certificate_of_residence         { fixture_file_upload("#{Rails.root}/spec/fixtures/images/license.jpg", "image/jpg") }
    certificate_of_residence_reserve { fixture_file_upload("#{Rails.root}/spec/fixtures/images/license.jpg", "image/jpg") }

    trait :with_depends do
      association :user, factory: :wallet_user
    end
  end
end
