class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many :child, class_name: Comment.name, foreign_key: :parent_id
  belongs_to :parent, class_name: Comment.name, optional: true
end
