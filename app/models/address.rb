class Address < ApplicationRecord
  enum address_type: { billing: 0, shipping: 1 }
  belongs_to :resource, polymorphic: true
end
