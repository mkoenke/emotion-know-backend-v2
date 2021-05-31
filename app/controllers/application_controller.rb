class ApplicationController < ActionController::API

  ##need to figure out how to run only one at a time - so if a parent is authorized it doesnt run authorization for a child and vice versa
    before_action :authorized_child, :authorized_parent
    
    def encode_token(payload)
        JWT.encode(payload, ENV['jwt_key'])
      end

      def auth_header
        auth = request.headers['Authorization']
        puts "AUTH HEADER #{auth}"
        request.headers['Authorization']
      end
    
      def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          puts "TOKEN #{token}"
          begin
           return decoded = JWT.decode(token, ENV['jwt_key'], true, algorithm: 'HS256') # added return - w/o get error below
            puts "DECODING! #{decoded} " 
          rescue JWT::DecodeError
            puts "ERROR: #{JWT::DecodeError}"

            nil
          end
        end
      end
      
      def current_child
        puts "DECODED TOKEN? #{decoded_token}"  #this is blank
        if decoded_token
          puts "HEREEEEEEEE" #this is not hitting  => getting error: [active_model_serializers] Rendered ActiveModel::Serializer::Null with Hash (0.05ms)
          # Filter chain halted as :authorized_child rendered or redirected
          # Completed 401 Unauthorized in 1ms (Views: 0.4ms | ActiveRecord: 0.0ms | Allocations: 465)
          child_id = decoded_token[0]['child_id']
          @child = Child.find_by(id: child_id)
          puts "CHILD: #{@child.username}"
          session[:child] = @child
        end
      end

      def current_parent
        if decoded_token 
          parent_id = decoded_token[0]['parent_id']
          @parent = Parent.find_by(id: parent_id)
          session[:parent] = @parent
        end
      end 
    
      def logged_in_child?
        !!current_child
      end

      def logged_in_parent?
        !!current_parent
      end

      def authorized_child
        render json: { message: 'Child: Please log in' }, status: :unauthorized unless logged_in_child?
      end
      def authorized_parent
        render json: { message: 'Parent: Please log in' }, status: :unauthorized unless logged_in_parent?
      end

end

#trying to run authorized parent after finding the authoprized child and its fucking it up