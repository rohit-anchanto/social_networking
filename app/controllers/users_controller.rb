class UsersController < ApplicationController
    load_and_authorize_resource except: [:index,:show]
    def my_profile
      @user = current_user
    end
    def index
      @users=User.all
    end
    def show
       @user=User.find(params[:id])
    end
    def destroy
      @user=User.find(params[:id])
      @user.destroy
      redirect_to root_path
    end
end