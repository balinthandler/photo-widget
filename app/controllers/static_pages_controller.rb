class StaticPagesController < ApplicationController
  require 'flickr'
  
  def index
    flickr = Flickr.new ENV['flickr_api_key'], ENV['flickr_secret']

    if params[:user_id].empty?
      flash[:alert] = "Please enter a valid user ID!"
    else
      begin
        @photos = flickr.photos.search(user_id: params[:user_id])
      rescue Flickr::FailedResponse => e
        @error = "Error : #{e.msg}"
      end
    end
  end
end
