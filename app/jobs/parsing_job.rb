class ParsingJob < ApplicationJob
  queue_as :parsing

  def perform(parsing_id)
    parsing = Parsing.find(parsing_id)
    ParserService.new(parsing: parsing).run!

    if parsing.success_callback_url.present?
      NotificationJobs::SuccessParsing.perform_later(parsing_id)
    end
  rescue => error
    if parsing.failure_callback_url.present?
      NotificationJobs::FailedParsing.perform_later(parsing_id, error.message)
    end

    raise error
  end
end
