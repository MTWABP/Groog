class Group < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :invites
  has_many :messages, as: :channel
  has_many :tasks
  has_many :group_memberships
  has_many :users, through: :group_memberships do
    def active
      where("group_memberships.active = ?", true)
    end
    def inactive
      where("group_memberships.active = ?", false)
    end
  end

  before_validation :generate_slug, on: :create

  def url
    "http://#{Rails.application.secrets.domain_name}/groups/#{slug}"
  end

  def to_s
    name
  end

  private
  def generate_slug
    loop do
      self.slug = rand(36**5).to_s(36)
      break if Group.find_by_slug(self.slug).nil?
    end
  end
end
