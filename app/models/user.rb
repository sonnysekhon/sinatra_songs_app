class User < ActiveRecord::Base
  has_many :songs
  has_many :upvotes
end