class ParentsController < ApplicationController
    skip_before_action :authorized_child
    skip_before_action :authorized_parent, only: [:create]

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
        # child = Child.find(parent.child.id) need to find all children and destroy all
        parent.destroy!
        # child.destroy!
        render json: {}
    end


    private

    def parent_params
        params.permit(:email, :password)
    end

end

