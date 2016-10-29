class Item < ApplicationRecord
  serialize :details, Array
  serialize :sizes, Array
end
