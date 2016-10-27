class Api::V1::ItemsController < Api::V1::BaseController
  def index
    @items = Item.all
    # @items = policy_scope(Item)
  end

  def show
    @item = Item.find(params[:id])
    p @item
  end

  # private
end
