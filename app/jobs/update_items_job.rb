require 'open-uri'

class UpdateItemsJob < ApplicationJob
  queue_as :default

  def perform(item_id)
    item = Item.find(item_id)
    puts "Updating info for #{item.name}..."
    item_page = Nokogiri::HTML(open("http://www.asos.com/asos/prd/#{item.sku}"))

    new_name = item_page.css('div.product-hero h1').text
    item.full_name = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.brand = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.product_code = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.in_stock = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.details = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.sizes = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.color = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.price = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.washing_instructions = new_name unless new_name.empty?

    new_name = item_page.css('').text
    item.materials = new_name unless new_name.empty?

    p item.name
    item.save!
  end
end
