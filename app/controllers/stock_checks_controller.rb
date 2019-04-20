class StockChecksController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @item = Item.find_by(code: params[:code])
    @report = StockCheckReport.find_by(id: params[:stock_check_report_id])
    if @item.present?
      @stock_check = StockCheck.find_or_initialize_by(
        item_id: @item.id,
        stock_check_report_id: @report.id
      )
    else
      @stock_check = StockCheck.find_or_initialize_by(
        code: params[:code],
        stock_check_report_id: @report.id
      )
    end
    update_stock_check
    render json: @stock_check.to_json, status: 200
  end

  private

  def update_stock_check
    if @stock_check.persisted?
      @stock_check.quantity = @stock_check.quantity + 1
    else
      @stock_check.state = "pending"
    end
    @stock_check.save
  end
end