require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.create(:user)).to be_valid
  end

  context 'default role' do
    let(:user) { FactoryBot.create(:user)}
    it {expect(user.roles[0].name).to eq('customer')}
  end

end
