require 'rails_helper'

RSpec.describe Api::V1::PurchaseController, type: :controller do
  render_views

  let!(:user) { User.create(email: 'testing@seasons.com') }
  let!(:library) { Library.create(user: user) }
  let(:movie) do
    Movie.create(title: 'Batman Begins', plot: 'Batman begins his journey')
  end
  let(:purchase_option) { PurchaseOption.create(content: movie, quality: 'sd', price: 10.00) }

  describe 'POST create' do
    context '' do
      it 'should create library contents for the library of the user' do
        post :create, params:
        { purchase:
          { purchase_option_id: purchase_option.id }, user_id: user.id },
                      format: :json

        expect(response.body).to include_json(data:
          { id: Purchase.first.id.to_s, type: 'purchases' })
        expect(user.library.library_contents.count).to eq(1)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
