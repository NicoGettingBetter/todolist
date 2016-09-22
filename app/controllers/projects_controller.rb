class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]
  def index
    respond_with Project.all
  end

  def create
    respond_with Project.create(project_params)
  end

  def update
    respond_with project.update(project_params)
  end

  def destroy
    project = Project.find_by(id: params[:id])
    Task.delete project.tasks
    project.delete
    respond_with :ok
  end

  private

    def set_project
      project = Project.find_by(id: params[:id])
    end

    def project_params
      params.require(:project).permit(:title)
    end
end
