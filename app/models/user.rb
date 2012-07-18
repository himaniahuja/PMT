# == This class defines a user
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  role                   :string(255)
#
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role, :project_ids

  has_many :projects, :foreign_key => :owner

  # validates username and role in user table for presence
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, :within => 6..30
  validates_presence_of :role


  ROLES = %w[admin manager developer banned] # defined roles for the project

  has_many :involvements, :foreign_key => :user_id,
                          :dependent => :nullify
  has_many :projects, :through => :involvements,
                      :source => :project
  has_many :efforts
end


