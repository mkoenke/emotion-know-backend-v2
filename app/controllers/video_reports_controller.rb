    class VideoReportsController < ApplicationController
        skip_before_action :authorized_child, :authorized_parent, only: [:index, :create, :show,]
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
            # parent = Parent.find(params[:id])
            # if report.save
            #     ParentMailer.sentiment_report(parent).deliver_now
            # end
            render json: video_report
        end
        
        def destroy
            video_report = VideoReport.find(params[:id])
            video_report.destroy!
            render json: {}
        end
    
        def update
            report = VideoReport.find(params[:id])
            report.update!(video_report_params)
            render json: report
        end
    
        private
    
        def video_report_params
            params.permit( :title, :video_entry_id, :parent_id, :child_id, :anger, :disgust, :fear, :joy, :sadness, :surprise)
        end
    
    end
        
    
    
