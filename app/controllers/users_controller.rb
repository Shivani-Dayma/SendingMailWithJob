class UsersController < ApplicationController
skip_before_action :verify_authenticity_token, only: [:create]


  def create
    @user = User.new(user_params)
    if @user.save
    SendEmailJob.perform_async(@user.id)
    render json: { message: 'User registered successfully' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  

private

def user_params
params.permit(:name, :email)
end

end
  