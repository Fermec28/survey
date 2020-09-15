
FactoryBot.define do
    factory :survey do
        description { Faker::Lorem.paragraph}
    end
end