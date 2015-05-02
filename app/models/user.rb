class User < ActiveRecord::Base
  has_secure_password validations: false

  ROLES = ["user", "admin", "guest"]

  validates :email, uniqueness: true, allow_nil: true
  validates :email, presence: true, email: true, unless: :guest?
  validates :password, length: { in: 6..30 }, on: :create, unless: :guest?
  validates :password, presence: true, on: :create, unless: :guest?
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: ROLES,
    message: "%{value} is not a valid role" }

  before_validation :set_guest, if: :guest?

  def user?
    role == "user"
  end

  def admin?
    role == "admin"
  end

  def guest?
    role == "guest"
  end

  def self.create_guest
    create role: "guest"
  end

  private

  def set_guest
    self.name = "Guest"
    self.email = nil
  end
end
