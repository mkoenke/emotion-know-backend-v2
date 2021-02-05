class ChildrenController < ApplicationController
    skip_before_action :authorized_child, :authorized_parent, only: [:create, :show, :reports]
    def index 
        children = Child.all
        render json: children
    end

    def show
        child = Child.find(params[:id])
        render json: child
    end

    def create
        child = Child.create!(child_params)
        if child.valid?
            @token = encode_token(child_id: child.id)
            render json: {child: ChildSerializer.new(child), jwt: @token}, status: :created
        else 
            render json: {error: "failed to create child"}, status: :not_acceptable
        end
    end
    
    def reports
        child = Child.find(params[:id])
        reports = Report.where(child_id: child.id)
        puts reports #how do i get this to be json data to be able to fetch it from front end
        render json: reports
    end 
    
    def destroy
        child = Child.find(params[:id])
        child.destroy!
        render json: {}
    end

    def update
        child = Child.find(params[:id])
        child.update!(child_params)
        render json: child
    end

    private

    def child_params
        params.permit(:username, :password, :image, :parent_id)
    end

end
