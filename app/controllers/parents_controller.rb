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
        puts "IN CREATE METHOD"
        parent = Parent.create!(parent_params)
        # if parent.save 
        #     ParentMailer.welcome_email(parent).deliver_now
        # end 
        puts parent
        if parent.valid?
            @token = encode_token(parent_id: parent.id)
            puts @token
            render json: {parent: ParentSerializer.new(parent), jwt: @token}, status: :created
        else 
            render json: {error: "failed to create parent"}, status: :not_acceptable
        end
      
    end
    
    def destroy
        parent = Parent.find(params[:id])
        parent.destroy!
        render json: {}
    end

    def update
        parent = Parent.find(params[:id])
        parent.update!(parent_params)
        render json: parent
    end

    private

    def parent_params
        params.permit(:email, :password)
    end

end

