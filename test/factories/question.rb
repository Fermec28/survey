FactoryBot.define do
    factory :question do
        description { Faker::Lorem.paragraph}
    end
end