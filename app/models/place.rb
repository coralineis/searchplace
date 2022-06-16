class Place < ApplicationRecord
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  belongs_to :place_genre
  has_many :tag_maps, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Like.group(:place_id).order(Arel.sql('count(place_id) desc')).pluck(:place_id))
    end
  end

  def sava_tags(tags)
    tag_list = tags.split(/[[:blank:]]+/)
    current_tags = self.tags.pluck(:name)
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
    p current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_place_tag = Tag.find_or_create_by(name: new)
      self.tags << new_place_tag
    end
  end

  enum prefecture: {
    hokkaido: 1, aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7,
    ibaraki: 8, tochigi: 9, gunma: 10, saitama: 11, chiba: 12, tokyo: 13, kanagawa: 14,
    niigata: 15, toyama: 16, ishikawa: 17, fukui: 18, yamanashi: 19, nagano: 20, gifu: 21, shizuoka: 22, aichi: 23,
    mie: 24, shiga: 25, kyoto: 26, osaka: 27, hyogo: 28, nara: 29, wakayama: 30,
    tottori: 31, shimane: 32, okayama: 33, hiroshima: 34, yamaguchi: 35, tokushima: 36, kagawa: 37, ehime: 38, kochi: 39,
    fukuoka: 40, saga: 41, nagasaki: 42, kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46, okinawa: 47
  }
end
