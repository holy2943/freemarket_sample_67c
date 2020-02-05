class ItemsController < ApplicationController
  
  def index

  end

  def new
    @item = Item.new
    1.times{ @item.images.build }
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  def edit
    @item = Item.find(params[:id])
    @image = Image.find(params[:id])
  end

  def update
    item= Item.find(params[:id])
    item.update(item_params)
    redirect_to root_path
  end


  def create
    @item = Item.create(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.where(id: @item.seller_id)
    @region = Region.find_by(id:@item.region_id)
    @condition = Condition.find_by(id:@item.condition_id)
    @postage = Postage.find_by(id:@item.postage_id)
    @shipping_date = ShippingDate.find_by(id:@item.shipping_date_id)
  end

  def confirmation
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(
      :seller_id, :categories_id, :name, :description, :postage_id, :region_id, :shipping_date_id, :price, :condition_id, :categories_id, :status, images_attributes: [:id, :image]
    )
  end

end
