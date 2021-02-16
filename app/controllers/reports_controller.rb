class ReportsController < ApplicationController
    
    def index 
        reports = Report.all
        render json: reports
    end

    def show
        report = Report.find(params[:id])
        render json: report
    end

    def create
        report = Report.create!(report_params)
        render json: report
    end

    private

    def report_params
        params.permit(:title, :content, :journal_entry_id, :parent_id, :child_id)
    end

end
