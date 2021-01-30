class LikesController < ApplicationController
    before_action :find_post,:find_likeable_id,:find_likeable_type
    def create
        if already_liked?
            flash[:notice] = "You can't like more than once"
        else
            Like.create(user_id: current_user.id,likeable_id:find_likeable_id,
            likeable_type:find_likeable_type)
          end
          redirect_to post_path(@post)
    end
    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like = Like.find(params[:id])
          @like.destroy
        end
        redirect_to post_path(@post)
    end
    private
    def find_likeable_type
       if(params[:comment_id])
          return "Comment"
       else
        return "Post"
       end
    end
    def find_likeable_id
        if(params[:comment_id])
            return params[:comment_id]
         else
          return params[:post_id]
         end
    end
    def already_liked?
       Like.where(user_id:current_user.id,likeable_id:
       find_likeable_id,likeable_type:find_likeable_type).exists?

    end
    def find_post
        @post=Post.find(params[:post_id])
    end
end 