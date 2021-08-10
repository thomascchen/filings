class FilingsController < ApplicationController
  def index
    render json: 
      FilingSerializer.new(
        Filing.includes(:filer, awards: :receiver).order(tax_year: :desc),
        include: [:filer, :awards, "awards.receiver"]
      ).serializable_hash.as_json
  end

  def show
    render json:
      FilingSerializer.new(
        Filing.includes(awards: :receiver).find(params[:id]),
        include: [:filer, :awards, "awards.receiver"]
      ).serializable_hash.as_json
  end
end
