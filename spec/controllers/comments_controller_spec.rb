require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }
  let(:project){ FactoryGirl.create(:project, user: user) }
  let!(:task){ FactoryGirl.create(:task, project: project) }

  before(:each) do
    ability
    log_in user
    comment_ability
  end

  describe 'POST create' do
    it 'creates new comment' do
      expect {
        post :create,
          params: {
            project_id: project.id,
            task_id: task.id,
            comment: FactoryGirl.attributes_for(:comment, task: task)
          },
          format: :json
      }.to change(Comment, :count).by(1)
    end
  end

  describe "PUT update" do
    let(:comment){ FactoryGirl.create(:comment, task: task) }
    
    it "updates comment" do
      put :update,
        params: {
          project_id: project.id,
          task_id: task.id,
          id: comment.to_param,
          comment: {text: 'new text'}
        },
        format: :json
      comment.reload
      expect(comment.text).to eq('new text')
    end
  end

  describe "DELETE destroy" do
    let!(:comment){ FactoryGirl.create(:comment, task: task) }

    it "destroys comment" do
      expect {
        delete :destroy,
          params: {
            project_id: project.id,
            task_id: task.id,
            id: comment.to_param,
          },
          format: :json
      }.to change(Comment, :count).by(-1)
    end
  end
end
