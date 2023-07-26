class Post < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :likes, as: :record

  validates :title, presence: true
  validates :body, presence: true
  validates :description, presence: true
  validates :published, inclusion: { in: [true, false] }
  validates :comments_enabled, inclusion: { in: [true, false] }

  has_rich_text :body
  has_rich_text :description

  paginates_per 10

  include FormatDate
  include Parameter
  extend SelectData

  class << self
    def take_all_by_page(page)
      includes(:category)
        .where(published: true)
        .order(created_at: :desc)
        .page(page)
    end

    def find_published_by_id(id)
      includes(:category)
        .where(published: true)
        .find(id)
    end
  end

  def liked_by?(user)
    likes.where(user:).any?
  end

  def unlike(user)
    likes.where(user:).destroy_all
  end

  def like(user)
    likes.where(user:).first_or_create
  end
end
