# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :author
    title { Faker::Lorem.sentence(word_count: 10) }
    content { Faker::Lorem.sentence(word_count: 30) }
  end
end
