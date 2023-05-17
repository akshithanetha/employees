class Employee < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"

  belongs_to :manager, class_name: "Employee", optional: true

  # ROLES = %w{HR manager subordinate}

  def jwt_payload
    super
  end
  def is_manager?
    role == manager
  end

  # ROLES.each do |role_name|
  #   define_method "#{role_name}?" do
  #     role == role_name
  #   end
  # end

 
end
