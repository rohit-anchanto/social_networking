class UsersController < ApplicationController
    load_and_authorize_resource except: [:index,:show]
    def friends
      @user=User.find(params[:user_id])
      @friends=@user.all_friends
    end
    def pendingrequests
      @user=User.find(params[:user_id])
      @pendingrequests=@user.pending_requests
    end
    def receievedrequests
      @user=User.find(params[:user_id])
      @r=@user.received_requests
    end
    def my_profile
      @user = current_user
    end
    def index
      @users=User.all
    end
    def show
       @user=User.find(params[:id])
       if(@user==current_user)
        redirect_to my_profile_path
       end
    end
    def destroy
      @user=User.find(params[:id])
      @user.destroy
      redirect_to root_path
    end
end