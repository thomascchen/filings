class ReceiversController < ApplicationController
  def index
    render json: ReceiverSerializer
      .new(Receiver.filtered_by_state(params[:state]))
      .serializable_hash
      .as_json
  end
end
