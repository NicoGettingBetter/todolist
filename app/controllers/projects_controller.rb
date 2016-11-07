class ProjectsController < ApplicationController
  before_action :set_current_user, :authenticate_user!
  load_and_authorize_resource  
  
  def index
    respond_with Project.where(user_id: current_user.id)
  end

  def create
    respond_with Project.create(project_params.merge(user_id: current_user.id))
  end

  def update
    project = Project.find_by(id: params[:id])
    respond_with project.update(project_params)
  end

  def destroy
    project = Project.find_by(id: params[:id])
    Task.delete project.tasks
    respond_with project.destroy
  end

  private
    def project_params
      params.require(:project).permit(:title, :user_id, :id, :created_at, :updated_at)
    end
end
