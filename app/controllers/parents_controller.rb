class ParentsController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create]
    def index 
        parents = Parent.all
        render json: parents
    end

    def show
        parent = Parent.find(params[:id])
        render json: parent
    end

    def create
        parent = Parent.create!(parent_params)
        puts parent
        if parent.valid?
            @token = encode_token(parent_id: parent.id)
            puts @token
            render json: {parent: ParentSerializer.new(parent), jwt: @token}, status: :created
        else 
            render json: {error: "failed to create parent"}, status: :not_acceptable
        end
      
    end

    private

    def parent_params
        params.permit(:email, :password)
    end

end

