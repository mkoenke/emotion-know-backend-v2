    class VideoReportsController < ApplicationController
        skip_before_action :authorized_child, :authorized_parent, only: [ :create]
  
        def create
            video_report = VideoReport.create!(video_report_params)
            render json: video_report
        end
   
        private
    
        def video_report_params
            params.permit( :title, :video_entry_id, :parent_id, :child_id, :anger, :disgust, :fear, :joy, :sadness, :surprise)
        end
    
    end
        
    
    
