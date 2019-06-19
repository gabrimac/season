require 'rails_helper'

RSpec.describe Library, type: :model do
  let!(:user) { User.create(email: 'testing@seasons.com') }
  let!(:library) { Library.create(user: user) }
  let(:season) do
    Season.create(title: 'Breaking Bad season 1',
                  plot: 'Crazy madman selling drugs')
  end
  let(:movie) do
    Movie.create(title: 'Batman Begins', plot: 'Batman begins his journey')
  end

  describe '.library_contents_by_order' do
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

    it 'should return the libraries in order by expired_date' do
      expect(library.library_contents_by_order.first.id).to eq(@lcon2.id)
      expect(library.library_contents_by_order.second.id).to eq(@lcon1.id)
    end
  end
end
