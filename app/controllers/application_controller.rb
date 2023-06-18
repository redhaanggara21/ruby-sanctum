class ApplicationController < ActionController::API

    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

    private
    def not_destroyed
        render json: {
            errors: e.record_error
        }, 
        status: :unproccessable_entity
    end

end
