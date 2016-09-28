class FileAttachmentsController < ApplicationController
  def create
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:task_id])
    comment = task.comments.find_by(id: params[:comment_id])
    respond_with project, task, comment, comment.file_attachments.create(file_params)
  end

  def destroy
    respond_with FileAttachment.find_by(id: params[:id]).destroy
  end

  private

    def file_params
      params.require(:file).permit(:url, :comment_id)
    end
end
