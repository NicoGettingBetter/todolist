require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, user: user)}
  
  [:title,
    :project_id].each do |field|
      it { should have_db_column(field) }
      it { should validate_presence_of(field)}
    end

  [:done,
    :deadline,
    :priority].each do |field|
      it { should have_db_column(field) }
    end

  it { should have_many(:comments) }
  it { should belong_to(:project) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:task, project: project)).to be_valid
  end
end
