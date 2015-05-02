class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :author

  def author
    object.user.name
  end

end
