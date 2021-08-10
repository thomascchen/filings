class FilingsController < ApplicationController
  def index
    render json: 
      FilingSerializer.new(
        Filing.includes(:filer, :awards, :receivers).order(tax_year: :desc),
        include: [:filer, :awards, :receivers]
      ).serializable_hash.as_json
  end

  def show
    render json:
      FilingSerializer.new(
        Filing.includes(:filer, :awards, :receivers).find(params[:id]),
        include: [:filer, :awards, :receivers]
      ).serializable_hash.as_json
  end
end
