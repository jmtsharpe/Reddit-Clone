class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  has_many :post_subs
  has_many :posts, through: :post_subs
  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id,
    primary_key: :id,
    inverse_of: :sub
    )


end
