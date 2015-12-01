class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
    @groups = Group.all
  end

  def show
    @groups = Group.all
  end

  def new
    @groups = Group.all
  end

  def edit
    @groups = Group.all
  end

  def create
  end

  def update
    #Get array from hash user_param
    user_params_as_array = user_params.values[1]
    #User_param with at least one group
    if user_params_as_array.count > 1
      if check_user_grups(get_groups_from_param(user_params), get_current_user_from_form(user_params))
        update_user_with_group(user_params[:group_ids], @user)
      else
        redirect_with_reject_of_update_of_user(@user)
      end
      #Empty user_param
    elsif user_params_as_array.count == 1
      update_user_with_group(user_params[:group_ids], @user)
    end
  end

  def destroy
  end

  def check_user_grups params,user
    delete_empty_char = params.pop
    user_params_as_array_to_int = params.map(&:to_i)
    if(user_params_as_array_to_int - user.group_ids).empty?
      return true
    else return false
    end
  end


def save_group_to_user param,user
  if user.update(:group_ids => param)
    true
  else
    false
end
end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  def get_current_user_from_form param
    User.find(param.values[0].to_i)
  end

  def update_user_with_group param, user
    respond_to do |format|
      if save_group_to_user(param, user)
        format.html { redirect_to user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: user }
      end
    end
  end
  def redirect_with_reject_of_update_of_user user
    respond_to do |format|
      format.html { redirect_to user, notice: "User cannot be assign to this group"}
      format.json { render json: user.errors, status: :unprocessable_entity }
    end
  end
  def get_groups_from_param param
    user_params_as_array = param.values[1]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:current_user, :group_ids => [])
  end


end
