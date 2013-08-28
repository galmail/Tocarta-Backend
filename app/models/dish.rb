# encoding: utf-8
# == Schema Information
#
# Table name: dishes
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  active             :boolean          default(TRUE)
#  position           :integer
#  description        :text
#  price              :decimal(, )
#  rating             :decimal(, )
#  reviews            :integer
#  story              :text
#  video              :string(255)
#  nutrition_facts    :string(255)
#  badge_name         :string(255)
#  short_title        :string(255)
#  rate_me            :boolean          default(TRUE)
#  chain_id           :integer
#

#!/bin/env ruby

class Dish < ActiveRecord::Base
  before_save :associate_chain
  has_many :combos, :through => :dish_combo_associations
  has_many :dish_combo_associations

  has_many :sections, :through => :dish_section_associations
  has_many :dish_section_associations
  has_many :subsections, :through => :dish_subsection_associations
  has_many :dish_subsection_associations
  has_many :order_items
  has_many :comments
  has_many :dish_variation_set_associations
  has_many :dish_variation_sets, :through => :dish_variation_set_associations
  has_many :dish_type_associations
  has_many :dish_types, :through => :dish_type_associations
  belongs_to :chain
  has_one  :nutrition_fact
  
  
  has_many :modifier_lists, :through => :dish_modifier_list_associations
  has_many :dish_modifier_list_associations
  attr_accessible :modifier_list_ids

  # Tag strategy
  has_and_belongs_to_many :ingredients
  attr_accessible :ingredient_ids

	has_attached_file(
	 :photo,
	 :path => ":chain_rest_id/img/dishes/:style/dish_:id.:extension",
	 :styles => { :large => TocartaAdmin::Application::IMAGE_LARGE_SIZE, :thumb => TocartaAdmin::Application::IMAGE_THUMBNAIL_SIZE, :mini => TocartaAdmin::Application::IMAGE_MINI_SIZE }
	)
	translates :name, :description, :story, :short_title, :badge_name, :fallbacks_for_empty_translations => true
	attr_accessible :name, :active, :position, :description, :price, :rating, :reviews, :story, :video, :nutrition_facts, :short_title, :badge_name, :photo, :rate_me, :chain_id
	attr_accessible :section_ids, :subsection_ids, :dish_type_ids, :dish_variation_set_ids, :sd_dish_id

    ### Validations ###

  validates :name, :price, :presence => true
  #validates_attachment_presence :photo
  validates :badge_name, :length => { :maximum => 11 }
  # validate :validate_min_sections

  def badge_name_enum
    if I18n.locale.to_s=="es"
      return ['-----','nuevo', 'recomendado', 'estrella']
    elsif I18n.locale.to_s=="fr"
      return ['-----','nouveau', 'recommandé', 'vedette']
    elsif I18n.locale.to_s=="de"
      return ['-----','neues', 'empfohlen', 'sterne']
    elsif I18n.locale.to_s=="cat"
      return ['-----','nou', 'recomanat', 'estrella']
    elsif I18n.locale.to_s=="en"
      return ['-----','new', 'recommended', 'starred']
    else
      return []
    end
  end
  
  def update_rating(comment_rating)
    num_comments = self.comments.length-1           # total number of comments (should filter only those comments that left)
    self.rating ||= 0                               # actual dish rating
    rate = ((num_comments.to_f*self.rating)+comment_rating.to_f)/(num_comments.to_f+1)
    self.rating = rate
    self.save
  end
  
  def associate_chain
    begin
      self.chain = self.sections.first.menu.restaurant.chain
    rescue Exception=>e
      # do nothing
    end
  end
  
  def validate_min_sections
    errors.add(:sections, "at least one section must be selected") if sections.length < 1
  end

  def self.with_comments
    joins(:comments)
  end

  def self.by_chain(chain_id)
    where(chain_id: chain_id)
  end

  def self.top_rating
    order('rating DESC')
  end
  def self.bottom_rating
    order('rating ASC')
  end

  def self.to_top_rating_hash_by_chain(chain_id)
    by_chain(chain_id).with_comments.top_rating.limit(10).inject({}) do |r,v|
      r[v.name] = v.rating.to_i
      r
    end
  end
  def self.to_bottom_rating_hash_by_chain(chain_id)
    by_chain(chain_id).with_comments.top_rating.limit(10).inject({}) do |r,v|
      r[v.name] = v.rating.to_i
      r
    end
  end
	
end
