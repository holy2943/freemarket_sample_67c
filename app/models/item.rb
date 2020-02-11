class Item < ApplicationRecord

  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images # item保存時に、imageテーブルにレコードを保存するため
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :region
    belongs_to_active_hash :condition
    belongs_to_active_hash :category
    belongs_to_active_hash :postage
    belongs_to_active_hash :shipping_date
  
    validates :name, :price, :condition_id, :postage_id, :region_id, :shipping_date_id, :description, :seller_id, :status, :category_id, presence: true

  def self.search(search)
    return Item.all unless search
    Item.where('name LIKE(?)',"%#{search}%").where(status: "exibiting")
  end

end