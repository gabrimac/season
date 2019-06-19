require 'rails_helper'

RSpec.describe Api::V1::LibrariesController, type: :controller do
  render_views

  let!(:user) { User.create(email: 'testing@seasons.com') }
  let!(:library) { Library.create(user: user) }
  let(:season) do
    Season.create(title: 'Breaking Bad season 1',
                  plot: 'Crazy madman selling drugs')
  end
  let(:movie) do
    Movie.create(title: 'Batman Begins', plot: 'Batman begins his journey')
  end

  describe 'GET index' do
    context 'send the param user_id in the url' do
      context 'the library of this user has no data' do
        it 'should return no Data' do
          get :index, params: { user_id: user.id }, format: :json

          expect(response).to have_http_status(:success)
          expect(response.body).to include_json(data: {
                                                  id: library.id.to_s,
                                                  type: 'libraries',
                                                  relationships: {
                                                    library_contents: {
                                                      data: []
                                                    }
                                                  }
                                                })
        end
      end

      context 'the library contains data order by expired_at' do
        before do
          @lcon1 = LibraryContent.create(library: library,
                                         content: season,
                                         expires_at: Date.today + 3.days,
                                         quality: 'sd')
          @lcon2 = LibraryContent.create(library: library,
                                         content: movie,
                                         expires_at: Date.today + 2.days,
                                         quality: 'sd')
        end

        it 'should return the library content in order' do
          get :index, params: { user_id: user.id }, format: :json

          expect(response).to have_http_status(:success)
          expect(response.body).to include_json(data: {
                                                  id: library.id.to_s,
                                                  type: 'libraries',
                                                  relationships: {
                                                    library_contents: {
                                                      data: [
                                                        {
                                                          type: 'library_contents',
                                                          id: @lcon2.id.to_s
                                                        },
                                                        {
                                                          type: 'library_contents',
                                                          id: @lcon1.id.to_s
                                                        }
                                                      ]
                                                    }
                                                  }
                                                },
                                                included: [
                                                  {
                                                    id: @lcon2.id.to_s,
                                                    type: 'library_contents',
                                                    attributes: {
                                                      expires_at: @lcon2.expires_at.to_s,
                                                      quality: @lcon2.quality
                                                    }
                                                  },
                                                  {
                                                    id: @lcon1.id.to_s,
                                                    type: 'library_contents',
                                                    attributes: {
                                                      expires_at: @lcon1.expires_at.to_s,
                                                      quality: @lcon1.quality
                                                    }
                                                  }
                                                ])
        end
      end
    end

    context 'not sending the param user_id in the url' do
      it 'should return the basket created for the user' do
        get :index, format: :json

        expect(response).to have_http_status(:success)
        expect(response.body).to include_json(errors: [{
                                                id: 'user_id',
                                                detail: 'Please provide param user_id',
                                                status: 422
                                                       }]
                                             )
      end
    end
  end


end
