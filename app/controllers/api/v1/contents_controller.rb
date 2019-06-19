module Api
  module V1
    class ContentsController < ApplicationController
      def index
        contents = Content.order(:created_at)
        render jsonapi: contents,
               cache: Rails.cache.fetch(contents.cache_key) do
                 contents.to_json
               end
      end
    end
  end
end
