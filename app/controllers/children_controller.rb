class ChildrenController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create, :update, :destroy]

    def create
        child = Child.create!(child_params)
        if child.valid?
            @token = encode_token(child_id: child.id)
            render json: {child: ChildSerializer.new(child), jwt: @token}, status: :created
        else 
            render json: {error: "failed to create child"}, status: :not_acceptable
        end
    end

    def update
        child = Child.find(params[:id])
        child.update!(child_params)
        render json: child
    end
    
    def destroy
        child = Child.find(params[:id])
        child.destroy!
        render json: {}
    end


    private

    def child_params
        params.permit(:username, :password, :image, :parent_id, :name)
    end

end
