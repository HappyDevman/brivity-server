# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :post
    association :author
    body { Faker::Lorem.sentence(word_count: 10) }
  end
end
