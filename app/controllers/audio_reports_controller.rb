class AudioReportsController < ApplicationController

    def create
        audio_report = AudioReport.create!(audio_report_params)
        render json: audio_report
    end
 
    private

    def audio_report_params
        params.permit( :title, :content, :audio_entry_id, :parent_id, :child_id)
    end

end
    

