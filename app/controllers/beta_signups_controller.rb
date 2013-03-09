class BetaSignupsController < ApplicationController

  def index
    @beta_user = BetaSignup.new
    render layout: 'prelaunch'
  end

  def create
    @beta_user = BetaSignup.new(params[:beta_signup])
    if @beta_user.save
      ## USE WITHOUT SIDEKIQ
      UserMailer.beta_signup_confirmation(@beta_user).deliver
      ## USE WITH SIDEKIQ
      # UserMailer.delay.beta_signup_confirmation(@beta_user)
      flash[:success] = "Added to Beta Announcement List"
      render 'success', layout: 'prelaunch'
    else
      flash.now[:error] = @beta_user.errors.full_messages.to_sentence
      render 'index', layout: 'prelaunch'
    end
  end

  def success
    render 'success', layout: 'prelaunch'
  end
end
