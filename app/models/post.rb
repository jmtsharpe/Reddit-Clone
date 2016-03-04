class Post < ActiveRecord::Base

  validates :title, :author_id, presence: true

  has_many :post_subs
  has_many :subs, through: :post_subs
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :posts
  )

  has_many(
    :comments
  )

  

end
