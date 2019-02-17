class SupplierDetailsController < ApplicationController
  def create
    @supplier_detail = SupplierDetail.new(supplier_detail_params)
    if @supplier_detail.save
      flash[:success] = "Supplier Detail created"
    else
      flash[:danger] = "Supplier Detail could not be created #{@supplier_detail.errors.full_messages.join(', ')}"
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @supplier_detail = SupplierDetail.find(params[:id])
    if @supplier_detail.update(supplier_detail_params)
      flash[:success] = "Supplier Detail updated"
    else
      flash[:danger] = "Supplier Detail could not be updated #{@supplier_detail.errors.full_messages.join(', ')}"
    end
    redirect_back(fallback_location: root_path)
  end

  def edit
    @supplier_detail = SupplierDetail.find(params[:id])
  end

  private

  def supplier_detail_params
    params.require(:supplier_detail).permit(:name, :contact, :location)
  end
end