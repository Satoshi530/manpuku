class Contact < ApplicationRecord
  validates :name, presence:true
  validates :email, presence:true
  validates :message, presence:true, length: {minimum: 2, maximum: 300 }
  validates :subject, presence:true
end
