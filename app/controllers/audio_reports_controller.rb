class AudioReportsController < ApplicationController
    
    # def index 
    #     audio_reports = AudioReport.all
    #     render json: audio_reports
    # end

    # def show
    #     audio_report = AudioReport.find(params[:id])
    #     render json: audio_report
    # end

    def create
        audio_report = AudioReport.create!(audio_report_params)
        render json: audio_report
    end
 
    private

    def audio_report_params
        params.permit( :title, :content, :audio_entry_id, :parent_id, :child_id)
    end

end
    

