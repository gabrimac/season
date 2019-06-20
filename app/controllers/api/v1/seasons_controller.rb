module Api
  module V1
    class SeasonsController < ApplicationController
      def index
        seasons = Season.order(:created_at)
        render jsonapi: seasons,
               include: [:episodes],
               fields: { episodes: %i[title plot] },
               cache: Rails.cache.fetch(seasons.cache_key) do
                 seasons.to_json(include: :comments, method: :episodes_number_order)
               end
      end
    end
  end
end

