require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }
  let!(:project){ FactoryGirl.create(:project, user: user) }

  before(:each) do
    ability
    log_in user
    task_ability
  end

  describe 'POST create' do
    it 'creates new task' do
      expect {
        post :create,
          project_id: project.id, 
          task: FactoryGirl.attributes_for(:task, project: project), 
          format: :json
      }.to change(Task, :count).by(1)
    end
  end

  describe "PUT update" do
    let(:task){ FactoryGirl.create(:task, project: project) }
    
    it "updates task" do
      put :update, 
          project_id: project.id,
          id: task.to_param,
          task: {title: 'new title'}, 
          format: :json
      task.reload
      expect(task.title).to eq('new title')
    end
  end

  describe "DELETE destroy" do
    let!(:task){ FactoryGirl.create(:task, project: project) }

    it "destroys task" do
      expect {
        delete :destroy,
          project_id: project.id,
          id: task.to_param,
          format: :json
      }.to change(Task, :count).by(-1)
    end
  end
end
