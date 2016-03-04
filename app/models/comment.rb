class Comment < ActiveRecord::Base

  validates :content, :author_id, presence: true

  belongs_to :post
  belongs_to(
    :parent_comment,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
    )

  belongs_to(
    :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :author_id
    )

  has_many(
    :child_comments,
    class_name: 'Comment',
    primary_key: :id,
    foreign_key: :parent_comment_id
  )

  

end
