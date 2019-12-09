require 'rails_helper'

describe Client do
  describe '.uniq_name' do
    it 'must return name with document' do
      client = Client.create!(name: 'Pedro da Silva', document: '354.308.060-13', email: 'pedro@email.com')

      expect(client.uniq_name).to eq 'Pedro da Silva (354.308.060-13)'
    end
    
  end
  
end