require 'rails_helper'

RSpec.describe FileAttachment, type: :model do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, user: user)}
  let(:task){ FactoryGirl.create(:task, project: project)}
  let(:comment){ FactoryGirl.create(:comment, task: task)}
  
  [:url,
    :comment_id].each do |field|
      it { should have_db_column(field) }
      it { should validate_presence_of(field)}
    end

  it { should belong_to(:comment) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:file_attachment, comment: comment)).to be_valid
  end
end
