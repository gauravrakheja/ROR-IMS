class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).includes(versions: :item)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item successfully added"
    else
      flash[:danger] = "Item could not be added #{@item.errors.full_messages.join(',')}"
    end
    redirect_back(fallback_location: root_path)
  end

  def get_barcode
    @item = Item.find_or_initialize_by(code: params[:code])
    if @item.persisted?
      case params[:change]
      when "increase"
        flash[:success] = "Item #{@item.code} successfully added"
        @item.change_quantity!(true)
        redirect_back(fallback_location: root_path)
      when "decrease"
        flash[:success] = "Item #{@item.code} successfully removed"
        @item.change_quantity!(false)
        redirect_back(fallback_location: root_path)
      end
    else
      case params[:change]
      when "increase"
        @item.save
        flash[:success] = "Item #{@item.code} successfully added"
        redirect_to edit_item_path(@item)
      when "decrease"
        flash[:danger] = "The item with code #{@item.code} does not exist"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item successfully updated"
    else
      flash[:danger] = "Item could not be updated #{@item.errors.full_messages.join(',')}"
    end
    redirect_back(fallback_location: root_path)
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:quantity, :price, :description, :internal_reference, :supplier_detail_id, :code)
  end
end