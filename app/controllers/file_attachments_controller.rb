class FileAttachmentsController < ApplicationController
  before_action :set_current_user, :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => :create
  
  def create
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:task_id])
    comment = task.comments.find_by(id: params[:comment_id])
    file = comment.file_attachments.create(file_params)
    authorize! :create, file
    respond_with project, task, comment, file
  end

  def destroy
    respond_with FileAttachment.find_by(id: params[:id]).destroy
  end

  private

    def file_params
      params.require(:file).permit(:url)
    end
end
