class UpdateItemsJob < ApplicationJob
  queue_as :default

  def perform(item_id)
    item = Item.find(item_id)
    puts "Updating info for item SKU: #{item.sku}..."

    browser = Watir::Browser.new(:phantomjs)
    browser.goto("http://www.asos.com/prd/#{item.sku}")

    new_name = browser.div(class: 'product-hero').h1.text
    item.full_name = new_name unless new_name.empty?

    new_brand = browser.div(class: 'brand-description').strong.text
    item.brand = new_brand unless new_brand.empty?

    new_product_code = browser.div(class: 'product-code').p.text
    item.product_code = new_product_code unless new_product_code.empty?

    new_in_stock = browser.div(class: 'out-of-stock').text
    item.in_stock = new_in_stock.empty?

    new_details = []
    browser.div(class: 'product-description').ul.when_present.lis.each { |i| new_details.push(i.text) unless i.text.empty? }
    item.details = new_details unless new_details.empty?

    new_sizes = []
    browser.div(class: 'size-section').select.when_present.options.each { |o| new_sizes.push(o.text) }
    new_sizes.delete_at(0) if new_sizes[0] == 'Please select'
    item.sizes = new_sizes unless new_sizes.empty?

    new_color = browser.span(class: 'product-colour').text
    item.color = new_color unless new_color.empty?

    new_price = browser.span(class: 'current-price').text
    item.price = new_price.delete('£').to_f unless new_price.empty?

    new_washing_instructions = browser.div(class: 'care-info').p.text
    item.washing_instructions = new_washing_instructions unless new_washing_instructions.empty?

    new_materials = browser.div(class: 'about-me').p.text
    item.materials = new_materials unless new_materials.empty?

    browser.screenshot.save("product_photos/#{item.brand}_#{item.sku}_#{item.product_code}")

    item.save!

    browser.close
  end
end
