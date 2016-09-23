class TasksController < ApplicationController
  def create
    project = Project.find_by(id: params[:project_id])
    respond_with project, project.tasks.create(task_params)
  end

  def update
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:id]).update(task_params)
    respond_with project, task
  end

  def show
    respond_with Task.find_by(id: params[:id])
  end

  def destroy
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:id])
    respond_with task.destroy
  end

  private

    def task_params
      params.require(:task).permit(:done, :deadline, :title, :priority, :project_id)
    end
end
