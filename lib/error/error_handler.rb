module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, e.to_s)
        end
      end
    end

    private

    def respond(error, status, message)
      if message.include?("Couldn't find User without an ID")
        render json: { errors: [{ id: 'user_id',
                                  detail: 'Please provide param user_id',
                                  status: 422 }] }
      else
        render json: { errors: [{ id: error,
                                  status: status,
                                  detail: message }] }
      end
    end
  end
end
