require 'rails_helper'

RSpec.describe Season, type: :model do
  describe '.episodes_number_order' do
    let!(:season) do
      Season.create(title: 'Breaking Bad season 1',
                    plot: 'Crazy madman selling drugs')
    end

    before do
      @episode2 = Episode.create(season: Season.first, title: 'The cat´s in the bag', plot: 'bath down through roof')
      @episode1 = Episode.create(season: Season.first, title: 'Pilot', plot: 'Jesse scapes')

      season.update_attributes(episodes_number: [@episode1.id, @episode2.id])
    end

    it 'should returns the episodes in order' do
      expect(season.episodes_number_order.first.title).to eq('Pilot')
      expect(season.episodes_number_order.second.title).to eq('The cat´s in the bag')
    end
  end
end
