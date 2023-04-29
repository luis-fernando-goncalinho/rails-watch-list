class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, :overview, uniqueness: true, presence: true

  before_destroy :check_bookmark

  def check_bookmark
    if self.bookmarks
      errors.add(:base, 'Can not delete because has a bookmark')
      raise ActiveRecord::InvalidForeignKey.new(self)
    end
  end
end
