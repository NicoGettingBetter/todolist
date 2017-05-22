require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, user: user)}
  let(:task){ FactoryGirl.create(:task, project: project)}
  
  [:text,
    :task_id].each do |field|
      it { should have_db_column(field) }
      it { should validate_presence_of(field)}
    end

  it { should have_many(:file_attachments) }
  it { should belong_to(:task) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:comment, task: task)).to be_valid
  end
end
