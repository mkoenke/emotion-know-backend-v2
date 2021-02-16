    require 'uri'
    require 'net/http'
    require 'openssl' 
    
    class VideoEntriesController < ApplicationController
        skip_before_action :authorized_child, :authorized_parent, only: [:create, :destroy, :index]
        def index
            video_entries = VideoEntry.all
            render json: video_entries
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
    
    
    



