class CommentsController < ApplicationController
    def new
        @post = Post.find params[:post_id]
        @comment = Comment.new(:post=>@post)
    end
    def create
        @comment = Comment.new(comment_params) 
        @comment.user = current_user
        @post=params[:post_id]
        @comment.post = Post.find(@post)
        if @comment.save 
          flash[:notice] = "Comment was created successfully." 
          redirect_to post_path(@post)
        else 
          redirect_to root_path 
        end 
    end

    private
    
    def comment_params
        params.require(:comment).permit(:com)
    end
end