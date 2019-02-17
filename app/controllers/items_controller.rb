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
    params.require(:item).permit(:quantity, :price, :description, :internal_reference, :supplier_detail_id)
  end
end