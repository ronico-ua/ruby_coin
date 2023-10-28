# frozen_string_literal: true

class Post < ApplicationRecord
  require 'i18n'

  translates :title, :subtitle, :description, :slug
  extend FriendlyId
  friendly_id :title, use: :globalize

  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :post_translations, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  before_save :deactivate_previous_main_post, if: :main_post?

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :main_post, inclusion: { in: [true, false] }

  enum status: { active: 0, inactive: 1 }

  scope :ordered, -> { order(created_at: :desc) }
  scope :with_translation, lambda {
    joins(:translations).where("
        post_translations.locale = ?
        AND post_translations.title IS NOT NULL
        AND post_translations.title != ''
        AND post_translations.subtitle IS NOT NULL
        AND post_translations.subtitle != ''
        AND post_translations.description IS NOT NULL
        AND post_translations.description != ''
      ", I18n.locale)
  }

  def truncated_description
    description.truncate(100, separator: /\s/)
  end

  def similar_posts(post)
    post_tags = post.tags.pluck(:id)
    Post.joins(:tags).where(tags: { id: post_tags }).where.not(id: post.id).distinct.limit(3)
  end

  def generate_slugs
    post_translations.each do |localized_post|
      localized_post.update!(slug: normalize_friendly_id(I18n.transliterate(localized_post.title)))
      localized_post.save!
    end
  end

  def translation_present?
    translation = post_translations.find_by(locale: I18n.locale)

    translation.present? &&
      translation.title.present? &&
      translation.subtitle.present? &&
      translation.description.present?
  end

  private

  def deactivate_previous_main_post
    previous_main_post = Post.find_by(main_post: true)
    previous_main_post.update(main_post: false) if previous_main_post.present? && previous_main_post != self
  end
end
