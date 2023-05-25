# frozen_string_literal: true

require 'contentful'

# interface for contentful api
class ContentfulInterface
  def initialize(args = {})
    @client = Contentful::Client.new(
      space: Rails.application.credentials.contentful[:space_id],
      access_token: Rails.application.credentials.contentful[:access_token],
      environment: Rails.application.credentials.contentful[:environment_id],
      dynamic_entries: :auto,
      raise_for_empty_fields: false,
      reuse_entries: true
    )
    @logger = Rails.logger
    @limit = args[:limit] || 25
    @skip = (args[:page] || 0) * @limit
  end

  def fetch_recipe(id)
    @logger.info('fetching a recipe...')
    recipe = @client.entry(id)
    if recipe.nil?
      @logger.error("Error: recipe with the following ID: #{id}, does not exist")
      return { errors: 'record does not exist' }
    end

    fetch_fields([recipe]) do |data, item|
      data[:description] = item.description
      data[:tags] = item.tags.try(:map, &:name).try(:join, ', ')
      data[:chef] = item.chef.try(:name)
      data
    end.last
  end

  def fetch_all_recipes
    @logger.info('fetching a recipes...')
    recipes = @client.entries(content_type: 'recipe', limit: @limit, skip: @skip).items

    fetch_fields(recipes) do |data, item|
      data[:id] = item.id
      data
    end
  end

  private

  def fetch_fields(items, &block)
    items.inject([]) do |arr, item|
      data = {}
      data[:title] = item.title
      data[:photo_url] = item.photo.url
      data.merge(block.call(data, item))
      arr.push(data)
    end
  end
end
