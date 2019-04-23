class StockCheckReportsController < ApplicationController
  def new
    @report = StockCheckReport.create
  end

  def index
    @reports = StockCheckReport.all.order(id: :desc)
  end

  def show
    @report = StockCheckReport.find(params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data @report.to_csv }
      format.xlsx
    end
  end

  def destroy
    @report = StockCheckReport.find(params[:id])
    @report.destroy
    redirect_to stock_check_reports_path
  end
end