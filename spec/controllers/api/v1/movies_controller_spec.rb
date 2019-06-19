require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  render_views

  let!(:movie) do
    Movie.create(title: 'Batman Begins', plot: 'Batman begins his journey')
  end

  describe 'GET index' do
    context 'the library of this user has no data' do
      it 'should return no Data' do
        get :index, format: :json

        expect(response).to have_http_status(:success)
        expect(response.body).to include_json(data: [{
                                                id: movie.id.to_s,
                                                type: 'movies',
                                                attributes: {
                                                  title: 'Batman Begins',
                                                  plot: 'Batman begins his journey'
                                                }
                                              }])
      end
    end
  end
end
