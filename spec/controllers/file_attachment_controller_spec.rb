require 'rails_helper'

RSpec.describe FileAttachmentsController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, user: user) }
  let(:task){ FactoryGirl.create(:task, project: project) }
  let!(:comment){ FactoryGirl.create(:comment, task: task) }

  before(:each) do
    ability
    log_in user
    file_ability
  end

  describe 'POST create' do
    it 'creates new file_attachment' do
      expect {
        post :create,
          params: {
            project_id: project.id,
            task_id: task.id,
            comment_id: comment.id,
            file: FactoryGirl.attributes_for(:file_attachment, comment: comment)
          },
          format: :json
      }.to change(FileAttachment, :count).by(1)
    end
  end

  describe "DELETE destroy" do
    let!(:file_attachment){ FactoryGirl.create(:file_attachment, comment: comment) }

    it "destroys file_attachment" do
      expect {
        delete :destroy,
          params: {
            project_id: project.id,
            task_id: task.id,
            comment_id: comment.id,
            id: file_attachment.to_param,
          },
          format: :json
      }.to change(FileAttachment, :count).by(-1)
    end
  end
end
