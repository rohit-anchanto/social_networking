class PostsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource except: [:index,:show]
    def index
      @my_posts = current_user.posts
      @all_posts = @my_posts
  
  
      #show his friends posts where(post_type: "friends") or (post_type: "everyone")
      @friends = current_user.all_friends
      @friends.each do |friend|
        @all_posts+= friend.posts.where(post_type: "friends").or(friend.posts.where(post_type: "public")) 
      end
  
      @posts = @all_posts
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
        post_visibility
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
        post_visibility
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
        params.require(:post).permit(:title,:description)
    end

    def post_visibility
      @type = params[:post_type_id]
      if @type == '1'
        @post.post_type = "public"
      elsif @type == '2'
        @post.post_type = "friends"
      else
        @post.post_type = "only me"
      end
    end
end