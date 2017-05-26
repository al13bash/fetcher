module Api
  module V1
    class ParsingsController < BaseController
      def index
        @parsings = Parsing.completed_desc
                           .page(params[:page]).per(params[:per_page])
      end

      def create
        @parsing = Parsing.new(parsing_params)

        if @parsing.save
          ParsingJob.perform_later(@parsing.id)

          render :show
        else
          render json: @parsing.errors, status: 400
        end
      end

      def show
        @parsing = Parsing.find(params[:id])
      end

      private

      def parsing_params
        params.require(:parsing).permit(
          :url,
          :success_callback_url,
          :failure_callback_url
        )
      end
    end
  end
end
