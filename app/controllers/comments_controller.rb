class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.commenter = current_user.name
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "コメントを投稿しました！"
      redirect_to topics_path
    else
      flash.now[:danger] = 'コメントに失敗しました'
      redirect_to root_path
    end

  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.create(params[:comment])
    @comment.destroy
    redirect_to topics_path
  end
end

private

def comment_params
  params.require(:comment).permit(:commenter, :body,:topic_id, :user_id)
end
