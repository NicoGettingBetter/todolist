require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user){ FactoryGirl.create(:user) }

  [:title,
    :user_id].each do |field|
      it { should have_db_column(field) }
      it { should validate_presence_of(field)}
    end

  it { should have_many(:tasks) }

  it { should belong_to(:user) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:project, user: user)).to be_valid
  end
end
