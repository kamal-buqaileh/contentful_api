# frozen_string_literal: true

FactoryBot.define do
  factory :fake_response_all_recipes, class: Hash do
    title { Faker::Food.dish }
    photo_url { Faker::Internet.url }
    id { Faker::Internet.uuid }
    skip_create
    initialize_with { attributes }
  end

  factory :fake_response_recipe, class: Hash do
    title { Faker::Food.dish }
    photo_url { Faker::Internet.url }
    description { Faker::Food.description }
    chef { Faker::Name.name }
    tags { "#{Faker::Name.name}, #{Faker::Name.name}" }

    skip_create
    initialize_with { attributes }
  end

  factory :fake_response_contentful_entries, class: OpenStruct do
    items do
      [OpenStruct.new(
        { title: Faker::Food.dish,
          photo: OpenStruct.new({ url: Faker::Internet.url }),
          id: Faker::Internet.uuid }
      )]
    end
    skip_create
    initialize_with { attributes }
  end
  factory :fake_response_contentful_entry, class: OpenStruct do
    title { Faker::Food.dish }
    photo { OpenStruct.new({ url: Faker::Internet.url }) }
    description { Faker::Food.description }
    chef { Faker::Name.name }
    tags { "#{Faker::Name.name}, #{Faker::Name.name}" }

    skip_create
    initialize_with { attributes }
  end
end
