module NotificationJobs
  class SuccessParsing < ApplicationJob
    def perform(parsing_id)
      parsing = Parsing.find(parsing_id)
      url = parsing.success_callback_url

      payload = ApplicationController.render(
        'api/v1/parsings/show',
        assigns: { parsing: parsing }
      )

      RestClient.patch(
        url,
        payload,
        content_type: :json, accept: :json
      )
    end
  end
end
