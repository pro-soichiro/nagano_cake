class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { pending:0,
                        waiting:1,
                        working:2,
                        completed:3}
end
