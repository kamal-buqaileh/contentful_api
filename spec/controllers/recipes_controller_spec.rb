# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  describe 'GET index' do
    before(:each) do
      @fake_response = FactoryBot.create_pair(:fake_response_all_recipes)
      allow_any_instance_of(ContentfulInterface).to receive(:fetch_all_recipes).and_return(@fake_response)
    end

    it 'assigns @recipes' do
      get :index
      expect(assigns(:recipes)).to eq(@fake_response)
    end
    it 'calls ContentfulInterface service' do
      expect_any_instance_of(ContentfulInterface).to receive(:fetch_all_recipes)
      get :index
    end
  end

  describe 'GET show' do
    before(:each) do
      @fake_response = FactoryBot.build(:fake_response_recipe)
      allow_any_instance_of(ContentfulInterface).to receive(:fetch_recipe).and_return(@fake_response)
    end
    it 'assigns @recipe' do
      get :show, params: { id: Faker::Internet.uuid }
      expect(assigns(:recipe)).to eq(@fake_response)
    end
    it 'calls ContentfulInterface service' do
      expect_any_instance_of(ContentfulInterface).to receive(:fetch_recipe)
      get :show, params: { id: Faker::Internet.uuid }
    end
  end
end
