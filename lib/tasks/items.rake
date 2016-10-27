namespace :items do
  desc 'Updating all the items (async)'
  task update_all: :environment do
    items = Item.all
    puts "Enqueuing update of #{items.size} items..."
    items.each do |user|
      UpdateItemsJob.perform_later(user.id)
    end
  end

  desc 'Updating a single item (sync)'
  task :update, [:item_id] => :environment do |_t, args|
    item = Item.find(args[:item_id])
    puts "Enriching #{item.name}..."
    UpdateItemJob.perform_now(item.id)
  end
end
