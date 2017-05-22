require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }

  before(:each) do
    ability
    log_in user
    project_ability
  end

  describe 'GET index' do    
    it 'returns success response' do
      FactoryGirl.create_list(:project, 3, user: user)
      get :index, format: :json
      expect(response).to be_success
    end

    it 'returns right count of projects' do
      FactoryGirl.create_list(:project, 3, user: user)
      user2 = FactoryGirl.create(:user)
      FactoryGirl.create_list(:project, 4, user: user2)
      get :index, format: :json      
      expect(JSON.parse(response.body).size).to eq(3)    
    end

    it 'returns project with user' do
      FactoryGirl.create(:project, user: user)
      get :index, format: :json
      expect(JSON.parse(response.body)[0]['user']).not_to be_empty
    end

    it 'returns project with tasks' do
      project = FactoryGirl.create(:project, user: user)
      FactoryGirl.create(:task, project: project)
      get :index, format: :json
      expect(JSON.parse(response.body)[0]['tasks']).not_to be_empty
    end
  end

  describe 'POST create' do
    it 'creates new project' do
      expect {
        post :create, params: { project: FactoryGirl.attributes_for(:project, user: user) }, format: :json
      }.to change(Project, :count).by(1)
    end
  end

  describe "PUT update" do
    let(:project){ FactoryGirl.create(:project, user: user) }
    
    it "updates project" do
      put :update, params: {id: project.to_param, project: {title: 'new title'}}, format: :json
      project.reload
      expect(project.title).to eq('new title')
    end
  end

  describe "DELETE destroy" do
    let!(:project){ FactoryGirl.create(:project, user: user) }

    it "destroys project" do
      expect {
        delete :destroy, params: {id: project.to_param}, format: :json
      }.to change(Project, :count).by(-1)
    end
  end
end
