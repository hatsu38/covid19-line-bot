# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  line_id             :string           not null
#  prefecture_code     :integer          not null
#  updatable_status_id :integer          not null
#  remind_time_id      :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_line_id  (line_id) UNIQUE
#
class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  include JpPrefecture

  DEFUALT_PREFECTURE_NAME = "東京都".freeze
  DEFUALT_UPDATABLE_STATUS = UpdatableStatus::UPDATED.id.freeze
  DEFUALT_REMIND_TIME = RemindTime::OCLOCK_8.id.freeze

  jp_prefecture :prefecture_code

  # デフォルトの都道府県は東京都とする
  attribute :prefecture_code, :integer, default: Prefecture.find_code_by_name(DEFUALT_PREFECTURE_NAME)
  attribute :updatable_status_id, :integer, default: DEFUALT_UPDATABLE_STATUS
  attribute :remind_time_id, :integer, default: DEFUALT_REMIND_TIME

  belongs_to_active_hash :updatable_status
  belongs_to_active_hash :remind_time

end
