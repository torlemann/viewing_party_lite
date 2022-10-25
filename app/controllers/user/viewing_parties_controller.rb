class User::ViewingPartiesController < ApplicationController

  before_action :set_users

  def new
    @viewing_party = ViewingParty.new(host_id: @user.id, movie_id: params[:movie_id])
  end

  def create   
    @viewing_party = ViewingParty.new(vp_params)
    if @viewing_party.save
      redirect_to user_dashboard_path
    else
      @errors = @viewing_party.errors
      render :new
    end
  end

  private

  def vp_params
    params.require(:viewing_party).permit(
      :movie_id,
      :host_id,
      :duration,
      :date,
      :start_time,
      user_ids: []
    )
  end

  def set_users
    @user = current_user
    @other_users = User.all_except(@user.id)
  end

end