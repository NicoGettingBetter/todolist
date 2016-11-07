require 'rails_helper'

RSpec.describe User, type: :model do
  [:email,
    :provider,
    :uid,
    :encrypted_password].each do |field|
      it { should have_db_column(field) }
    end

  it { should validate_presence_of(:email)}

  it { should have_many(:projects) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
end
