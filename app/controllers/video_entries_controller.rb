class VideoEntriesController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:index, :show, :create, :destroy]

    def index
        video_entries = VideoEntry.all
        render json: video_entries, adapter: nil
    end

    def show
        video_entry = VideoEntry.find(params[:id])
        render json: video_entry
    end

    def create
        video_entry = VideoEntry.create!(video_entry_params)
        attached_video = video_entry.video.attach(params[:video])    
        render json: video_entry
    end

    def destroy
        video_entry = VideoEntry.find(params[:id])
        video_entry.destroy!
        render json: {}
    end

    private

    def video_entry_params
        params.permit( :title, :video, :child_id)
    end

end
    



