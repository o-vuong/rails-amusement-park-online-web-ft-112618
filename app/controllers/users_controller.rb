class UsersController < ApplicationController
  before_action :check_session, only: [:show]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      render 'users/new'
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user && @user == current_user
      ride = @user.rides.create(attraction_id: params[:attraction][:id])
      @message = ride.take_ride
    end
    render 'users/show'
  end

  private

  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin)
  end

  def check_session
    redirect_to root_path unless logged_in?
  end
end
