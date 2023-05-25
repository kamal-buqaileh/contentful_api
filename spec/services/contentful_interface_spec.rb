# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContentfulInterface, type: :service do
  subject { ContentfulInterface.new }
  describe 'initialize' do
    it 'assigns @client' do
      expect(subject.instance_variable_get(:@client).present?).to be(true)
    end
    it 'should have @client holding Contentful::Client instance' do
      expect(subject.instance_variable_get(:@client).class.name).to eq('Contentful::Client')
    end
  end

  describe 'fetch_all_recipes' do
    before(:each) do
      fake_response = OpenStruct.new(FactoryBot.build(:fake_response_contentful_entries))
      allow_any_instance_of(Contentful::Client).to receive(:entries).with(content_type: 'recipe').and_return(fake_response)
    end

    it 'returns an array that includes titles, photo_urls and ids of the items' do
      data = subject.fetch_all_recipes
      expect(data.class.name).to eq('Array')
      expect(data[0].keys).to match(%i[title photo_url id])
    end
  end

  describe 'fetch_recipe' do
    before(:each) do
      fake_response = OpenStruct.new(FactoryBot.build(:fake_response_contentful_entry))
      allow_any_instance_of(Contentful::Client).to receive(:entry).and_return(fake_response)
    end

    it 'returns a recipe that includes title, photo_url and description, chef and tags of the items' do
      data = subject.fetch_recipe(1)
      expect(data.class.name).to eq('Hash')
      expect(data.keys).to match_array(%i[title photo_url description chef tags])
    end
  end
end
