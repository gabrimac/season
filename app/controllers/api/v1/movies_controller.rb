module Api
  module V1
    class MoviesController < ApplicationController
      def index
        movies = Movie.order(:created_at)
        render jsonapi: movies,
               cache: Rails.cache.fetch(movies.cache_key) do
                 movies.to_json
               end
      end
    end
  end
end
