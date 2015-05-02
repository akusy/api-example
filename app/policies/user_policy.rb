class UserPolicy < ApplicationPolicy

  [:show?, :update?, :destroy?].each do |method|
    define_method(method) { record_owner_or_admin? }
  end

  [:create?, :index?].each do |method|
    define_method(method) { record_admin? }
  end

  private

  def record_owner_or_admin?
    user == record || record_admin?
  end

end
