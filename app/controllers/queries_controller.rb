class QueriesController < ApplicationController


  def index
    @address = params[:address]
    @weight = params[:weight]

    if @address && @weight
      @response = Quote.estimate
      #create log creation
      render json: @response.as_json(only: [:id, :provider, :estimate])
    elsif @address == nil
      render json: {error: "Must Provide a query (missing address)"}, status: 400
    elsif @weight == nil
      render json: {error: "Must Provide a query (missing weight)"}, status: 400
    else
      render json: {error: "Must Provide a query (missing address & weight)"}, status: 400
    end
  end

end
