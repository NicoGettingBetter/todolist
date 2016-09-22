class CommentsController < ApplicationController
  def create
    respond_with Comment.create(comment_params)
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
      params.require(:comment).permit(:text, :file)
    end
end
