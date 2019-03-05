class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).includes(versions: :item)
  end

  def perform
    if params.has_key?(:event) && Item.available_events.include?(params[:event].to_sym)
      @item = Item.find(params[:id])
      if @item.public_send(params[:event])
        flash[:succes] = "Item updated"
      else
        flash[:danger] = "Action could not be performed #{@item.errors.full_messages.join(', ')}"
      end
    end
    redirect_back(fallback_location: root_path)
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
    unless @item.persisted?
      case params[:change]
      when "increase"
        @item.change_quantity!(true)
        redirect_to new_item_path(code: params[:code])
      when "decrease"
        flash[:danger] = "The item does not exist"
        redirect_back_or_to(root_path)
      end
    else
      case params[:change]
      when "increase"
        @item.change_quantity!(true)
      when "decrease"
        @item.change_quantity!(false)
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