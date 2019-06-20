module Api
  module V1
    class LibrariesController < ApplicationController
      def index
        library = current_user.library

        render jsonapi: library,
               include: :library_contents,
               cache: Rails.cache.fetch(library.cache_key) do
                 library.to_json(
                   include: :library_contents,
                   method: :library_contents_by_order
                 )
               end
      end
    end
  end
end
