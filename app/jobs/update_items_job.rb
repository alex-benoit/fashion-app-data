class UpdateItemsJob < ApplicationJob
  queue_as :default

  def perform(item_id)
    item = Item.find(item_id)
    puts "Updating info for #{item.full_name}..."

    browser = Watir::Browser.new(:phantomjs)
    browser.goto("http://www.asos.com/prd/#{item.sku}")

    new_name = browser.div(class: 'product-hero').h1.text
    # item.full_name = new_name unless new_name.empty?

    new_brand = browser.div(class: 'brand-description').strong.text
    # item.brand = new_brand unless new_brand.empty?

    new_product_code = browser.div(class: 'product-code').p.text
    # item.product_code = new_product_code unless new_product_code.empty?

    new_in_stock = browser.div(class: 'out-of-stock').h3.text
    # item.in_stock = new_in_stock.empty?

    # new_details = browser.div('').text
    # item.details = new_details unless new_details.empty?

    new_sizes = browser.div(class: 'colour-size-select').text
    # item.sizes = new_sizes unless new_sizes.empty?

    new_color = browser.div(class: 'color-section').span.text
    # item.color = new_color unless new_color.empty?

    new_price = browser.span(class: 'current-price').text
    # item.price = new_price unless new_price.empty?

    new_washing_instructions = browser.div(class: 'care-info').p.text
    # item.washing_instructions = new_washing_instructions unless new_washing_instructions.empty?

    new_materials = browser.div(class: 'about-me').p.text
    # item.materials = new_materials unless new_materials.empty?

    browser.close

    binding.pry
    # item_page = Nokogiri::HTML(open())
    # item.save!
  end
end
