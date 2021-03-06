class AccountController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      Mail.deliver_confirmation(@user.email, @user.full_name)
      flash[:notice] = "Hello #{@user.full_name}, welcome to NuggetHub."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    unauthorized! if cannot? :update, @user
  end

  def update
    @user = current_user
    unauthorized! if cannot? :update, @user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Your account was successfully updated.'
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
