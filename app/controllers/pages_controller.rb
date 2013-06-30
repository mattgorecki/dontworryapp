class PagesController < ApplicationController
  def home
    unless signed_in?
      redirect_to beta_signup_index_path
    end
  end
end
