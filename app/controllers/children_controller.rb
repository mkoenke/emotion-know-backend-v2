class ChildrenController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create]

    # def index 
    #     children = Child.all
    #     render json: children
    # end

    # def show
    #     child = Child.find(params[:id])
    #     render json: child
    # end

    def create
        child = Child.create!(child_params)
        if child.valid?
            @token = encode_token(child_id: child.id)
            render json: {child: ChildSerializer.new(child), jwt: @token}, status: :created
        else 
            render json: {error: "failed to create child"}, status: :not_acceptable
        end
    end

    private

    def child_params
        params.permit(:username, :password, :image, :parent_id)
    end

end
