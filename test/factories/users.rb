
FactoryBot.define do
    factory :user do
        email { Faker::Internet.email}
        password { Faker::Code.imei }
    end

    factory :fer_user, class: 'User' do
        email { Faker::Internet.email}
        password { 'test'}
    end 
end