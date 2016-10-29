namespace :items do
  desc 'Updating all the items (async)'
  task update_all: :environment do
    items = Item.all
    items.each do |user|
      UpdateItemsJob.perform_now(user.id)
      sleep 10
    end
  end

  desc 'Updating a single item (sync)'
  task :update, [:item_id] => :environment do |_t, args|
    item = Item.find(args[:item_id])
    UpdateItemsJob.perform_now(item.id)
  end
end
