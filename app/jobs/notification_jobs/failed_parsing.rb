module NotificationJobs
  class FailedParsing < ApplicationJob
    def perform(parsing_id, message)
      parsing = Parsing.find(parsing_id)
      url = parsing.failure_callback_url

      RestClient.patch(
        url,
        { message: message }.to_json,
        content_type: :json, accept: :json
      )
    end
  end
end
