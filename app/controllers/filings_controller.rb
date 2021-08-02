class FilingsController < ApplicationController
  def index
    render json: 
      FilingSerializer.new(
        Filing.includes(:filer, awards: :receiver).all,
        include: [:filer, :awards, "awards.receiver"]
      ).serializable_hash.as_json
  end
end
