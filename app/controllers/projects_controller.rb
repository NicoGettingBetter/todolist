class ProjectsController < ApplicationController
  def index
    respond_with Project.all
  end

  def create
    respond_with Project.create(project_params)
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
      params.require(:project).permit(:title)
    end
end
