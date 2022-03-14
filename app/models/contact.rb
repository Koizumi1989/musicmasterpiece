class Contact < ApplicationRecord
  validates :name, :email, :phone_number, :content, presence: true
end
