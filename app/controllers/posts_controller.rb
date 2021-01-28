class PostsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @posts=Post.all
     end
    def new
       @post=Post.new
    end
    
    def show 
       @post=Post.find(params[:id])
       @comments=@post.comments
       @comment = Comment.new(:post=>@post)
    end

    def create
        @post = Post.new(post_params) 
        @post.user = current_user
        if @post.save 
          flash[:notice] = "Post was created successfully." 
          redirect_to @post
        else 
          render 'new' 
        end 
    end

    def edit
       @post=Post.find(params[:id])
    end
    def update
        @post=Post.find(params[:id])
        if @post.update(post_params)
            flash[:notice] = "Post was updated successfully."
            redirect_to @post
          else
            render 'edit'
          end
    end

    def destroy
        @post=Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end

    private

    def post_params
        params.require(:post).permit(:name,:description)
    end
end