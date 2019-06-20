require 'rails_helper'

RSpec.describe Api::V1::SeasonsController, type: :controller do
  render_views

  let!(:season) do
    Season.create(title: 'Breaking Bad season 1',
                  plot: 'Crazy madman selling drugs')
  end

  before do
    @episode1 = Episode.create(season: Season.first, title: 'Pilot', plot: 'Jesse scapes')
    @episode2 = Episode.create(season: Season.first, title: 'The cat´s in the bag', plot: 'bath down through roof')

    season.update_attributes(episodes_number: [@episode1.id, @episode2.id])
  end

  describe 'GET index' do
    it 'should return the seasons with his episodes' do
      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(response.body).to include_json(data: [{
                                              id: season.id.to_s,
                                              type: 'seasons',
                                              attributes: {
                                                title: 'Breaking Bad season 1',
                                                plot: 'Crazy madman selling drugs'
                                              }
                                            }],
                                            included: [{
                                              id: @episode1.id.to_s,
                                              type: 'episodes',
                                              attributes: {
                                                title: 'Pilot',
                                                plot: 'Jesse scapes'
                                              }
                                            },
                                            {
                                              id: @episode2.id.to_s,
                                              type: 'episodes',
                                              attributes: {
                                                title: 'The cat´s in the bag',
                                                plot: 'bath down through roof'
                                              }
                                            }])
    end
  end

end
