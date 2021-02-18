require 'uri'
require 'net/http'
require 'openssl'

class JournalEntriesController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create, :destroy]

    # def index
    #     journal_entries = JournalEntry.all
    #     render json: journal_entries
    # end

    # def show
    #     journal_entry = JournalEntry.find(params[:id])
    #     render json: journal_entry
    # end

    def create
        journal_entry = JournalEntry.create!(journal_entry_params)
    
        url = URI("https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/x-www-form-urlencoded'
        request["x-rapidapi-key"] = ENV['rapidApi_key']
        request["x-rapidapi-host"] = 'twinword-emotion-analysis-v1.p.rapidapi.com'
        request.body = "text=#{journal_entry.content.split(" ").join("%20")}"
        response = http.request(request)
        resp = response.read_body
        parsed_resp = JSON.parse resp.gsub('=>', ':')
        inner_hash = parsed_resp["emotion_scores"]

        Report.create!(
            title: journal_entry.title,
            journal_entry_id: journal_entry.id,
            parent_id: journal_entry.child.parent.id,
            child_id: journal_entry.child.id,
            anger: inner_hash["anger"],
            disgust: inner_hash["disgust"],
            fear: inner_hash["fear"],
            joy: inner_hash["joy"],
            sadness: inner_hash["sadness"],
            surprise: inner_hash["surprise"],
        )
        render json: journal_entry      
    end
  
    def destroy
        journal_entry = JournalEntry.find(params[:id])
        journal_entry.destroy!
        render json: {}
    end

    private

    def journal_entry_params
        params.permit(:title, :content, :child_id)
    end

end
