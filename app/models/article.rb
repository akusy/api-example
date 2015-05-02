class Article < ActiveRecord::Base
  belongs_to :user

  validates :name, :content, :user, presence: true

end
