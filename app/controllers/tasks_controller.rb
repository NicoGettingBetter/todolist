class TasksController < ApplicationController
  before_action :set_current_user, :authenticate_user!
  load_and_authorize_resource
  
  def create
    project = Project.find_by(id: params[:project_id])
    respond_with project, project.tasks.create(task_params)
  end

  def update
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:id]).update(task_params)
    respond_with project, task
  end

  def destroy
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:id])
    respond_with task.destroy
  end

  private

    def task_params
      params.require(:task).permit(:done, :deadline, :title, :priority, :project_id, :id, :created_at, :updated_at)
    end
end
