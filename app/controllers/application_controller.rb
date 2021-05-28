class ApplicationController < ActionController::API
    before_action :authorized_child, :authorized_parent
    
    def encode_token(payload)
        JWT.encode(payload, ENV['jwt_key'])
      end

      def auth_header
        request.headers['Authorization']
      end
    
      def decoded_token
        if auth_header()
          token = auth_header.split(' ')[1]
          begin
            JWT.decode(token, ENV['jwt_key'], true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
      end
      
      def current_child
        if decoded_token
          child_id = decoded_token[0]['child_id']
          @child = Child.find_by(id: child_id)
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
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in_child?
      end
      def authorized_parent
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in_parent?
      end

end
