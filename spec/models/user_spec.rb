require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.build(:user) }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value("exemplo@exe.com").for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#generate_authentication_token!' do
  	it 'gera um token unico' do
  		allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
  		user.generate_authentication_token!

  		expect(user.auth_token).to eq('abc123xyzTOKEN')
  	end

  	it 'gera outro token se já existe um no banco' do
  		allow(Devise).to receive(:friendly_token).and_return('abc123xyzass', 'abc123xyzass', 'abc123xyzassdd')
  		existing_user = create(:user)
  		user.generate_authentication_token!

  		expect(user.auth_token).not_to eq(existing_user)
  	end
  end
end
