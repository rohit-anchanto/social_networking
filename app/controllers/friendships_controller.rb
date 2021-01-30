class FriendshipsController < ApplicationController
    before_action :find_reciever
    def create
        
        if((is_friendship?)&&current_user!=@reciever)
            @friendrequest=Friendship.new
            @friendrequest.sent_by=current_user
            @friendrequest.sent_to=@reciever
            if(@friendrequest.save)
                flash[:notice]="Friend request send succesfully"
                redirect_to user_path(@reciever)
            else
                flash[:notice]="Friend request does not send"
                redirect_to user_path(@reciever)
            end
        else
            flash[:notice]="Friend request does not send"
            redirect_to user_path(@reciever)
        end

    end

    def accept
        @friendship_accept=Friendship.where(sent_to_id:current_user,sent_by_id:params[:user_id])
        if(@friendship_accept)
            if @friendship_accept.update(status:true)
                flash[:notice]="Successfully Added Friend"
			    redirect_to user_friends_path(current_user)
		    else
                flash[:notice]="Not Addded"
                redirect_to user_friends_path(current_user)
            end
        end
    end
    def unfriend
        
        @user=User.find(params[:user_id])
		
        @friends=Friendship.find_by(sent_by:@user,sent_to:current_user)
        if(@friends)
            @friends.destroy
            redirect_to @user
        else
            @friends=Friendship.find_by(sent_by:current_user,sent_to:@user)
            redirect_to @user
        end	
    end
    def destroy
		@sender=User.find(params[:user_id])
		@receiver=User.find(params[:id])
		@friends=Friendship.find_by(sent_by:@sender,sent_to:@receiver)
		@friends.destroy
		redirect_to current_user
	end
    private

    def find_reciever
        @reciever=User.find(params[:user_id])
    end
    def is_friendship? #checking already friend or request sent or recieved
        !(Friendship.where(sent_by_id:current_user,sent_to_id:params[:user_id]).exists?) && !(
            Friendship.where(sent_to_id:current_user,sent_by_id:params[:user_id]).exists?) 
    end
end