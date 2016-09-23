class CommentsController < ApplicationController
  def create
    project = Project.find_by(id: params[:project_id])
    task = project.tasks.find_by(id: params[:task_id])
    respond_with project, task, task.comments.create(comment_params)
  end

  def update
    comment = Comment.find_by(id: params[:id])
    respond_with comment.update(comment_params)
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    respond_with comment.delete
  end

  private

    def comment_params
      params.require(:comment).permit(:text, :file, :task_id)
    end
end
