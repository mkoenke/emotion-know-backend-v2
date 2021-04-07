class ParentsController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create, :update]

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

    def update
        parent = Parent.find(params[:id])
        parent.update!(parent_params)
        render json: parent
    end

    def destroy
        parent = Parent.find(params[:id])
        parent.destroy!
        render json: {}
    end


    private

    def parent_params
        params.permit(:email, :password)
    end

end

