class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :author

  def author
    object.user.name
  end

end
