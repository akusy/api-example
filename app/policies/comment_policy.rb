class CommentPolicy < ApplicationPolicy

  [:update?, :destroy?].each do |method|
    define_method(method) { record_owner_or_admin? }
  end

  def create?
    user.user? || record_admin?
  end

  private

  def record_owner_or_admin?
    record.user == user || record_admin?
  end

end
