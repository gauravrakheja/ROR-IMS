class PagesController < ApplicationController
  def home
    @report = StockCheckReport.last
  end
end