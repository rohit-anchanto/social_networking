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
    def search
      if params[:user].present?
        @users=User.search(params[:user])
        @users=current_user.except_current_user(@users)
        if @users.present?
          respond_to do |format|
            format.js { render partial: 'users/result'}
          end
        else
          respond_to do |format|
            flash[:notice]="No user Present"
            byebug
            format.js { render partial: 'users/result'}
          end
        end
      else
        respond_to do |format|
          flash[:notice]="No user Present"
          format.js { render partial: 'users/result'}
        end
      end
    end
    def destroy
      @user=User.find(params[:id])
      @user.destroy
      redirect_to root_path
    end
end