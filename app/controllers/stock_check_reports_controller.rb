class StockCheckReportsController < ApplicationController
  def new
    @report = StockCheckReport.create
  end

  def index
    @reports = StockCheckReport.all.order(id: :desc)
  end

  def show
    @report = StockCheckReport.find(params[:id])
  end
end