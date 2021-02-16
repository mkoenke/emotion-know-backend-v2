    class VideoReportsController < ApplicationController
        skip_before_action :authorized_child, :authorized_parent, only: [:index, :create, :show]

        def index 
            video_reports = VideoReport.all
            render json: video_reports
        end
    
        def show
            video_report = VideoReport.find(params[:id])
            render json: video_report
        end
        
        def create
            video_report = VideoReport.create!(video_report_params)
            render json: video_report
        end
   
        private
    
        def video_report_params
            params.permit( :title, :video_entry_id, :parent_id, :child_id, :anger, :disgust, :fear, :joy, :sadness, :surprise)
        end
    
    end
        
    
    
