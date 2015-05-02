class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :content, :user, :article, presence: true

end
