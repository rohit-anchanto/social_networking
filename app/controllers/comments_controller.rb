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
    def edit
        @post = Post.find params[:post_id]
        @comment = Comment.find(params[:id])
    end
    def update
        @comment = Comment.find(params[:id]) 
        @post=Post.find(params[:post_id])
        if @comment.update(comment_params)
          flash[:notice] = "Comment was updated successfully." 
          redirect_to post_path(@post)
        else 
          render 'edit'
        end 
    end
    def destroy
        @comment=Comment.find(params[:id])
        @comment.destroy
        @post=Post.find(params[:post_id])
        redirect_to @post
    end
    private
    
    def comment_params
        params.require(:comment).permit(:com)
    end
end