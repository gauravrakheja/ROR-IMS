class StockChecksController < ApplicationController
  def create
    @item = Item.find_by(code: params[:code])
    @report = StockCheckReport.find_by(id: params[:stock_check_report_id])
    if @item.present?
      @stock_check = StockCheck.find_or_initialize_by(
        item_id: @item.id,
        stock_check_report_id: @report.id
      )
      unless @stock_check.persisted?
        @stock_check.quantity = @stock_check.quantity + 1
      end
      @stock_check.save
      render json: @stock_check.to_json, status: 200
    else
      render json: { code: params[:code] }, status: 400
    end
  end
end