require 'uri'
require 'net/http'
require 'openssl'

class AudioEntriesController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create, :destroy]

    # def index
    #     audio_entries = AudioEntry.all
    #     render json: audio_entries
    # end

    # def show
    #     audio_entry = AudioEntry.find(params[:id])
    #     render json: audio_entry
    # end

    def create
        audio_entry = AudioEntry.create!(audio_entry_params)
        attached_clip = audio_entry.clip.attach(params[:clip])
        clip_url = url_for(audio_entry.clip)
      
        url = URI("https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/x-www-form-urlencoded'
        request["x-rapidapi-key"] = ENV['rapidApi_key']
        request["x-rapidapi-host"] = 'twinword-emotion-analysis-v1.p.rapidapi.com'
        request.body = "text=#{audio_entry.content.split(" ").join("%20")}"
        response = http.request(request)
        resp = response.read_body      
        parsed_resp = JSON.parse resp.gsub('=>', ':')
        inner_hash = parsed_resp["emotion_scores"]
      
        AudioReport.create(
            title: audio_entry.title,
            audio_entry_id: audio_entry.id,
            parent_id: audio_entry.child.parent.id,
            child_id: audio_entry.child.id,
            anger: inner_hash["anger"],
            disgust: inner_hash["disgust"],
            fear: inner_hash["fear"],
            joy: inner_hash["joy"],
            sadness: inner_hash["sadness"],
            surprise: inner_hash["surprise"],
        )      
        render json: audio_entry       
    end
  
    def destroy
        audio_entry = AudioEntry.find(params[:id])
        audio_entry.destroy!
        render json: {}
    end

    private

    def audio_entry_params
        params.permit( :title, :content, :clip, :child_id)
    end

end


