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
  DEFUALT_UPDATABLE_STATUS = UpdatableStatus::UPDATED.freeze
  DEFUALT_REMIND_TIME = RemindTime::OCLOCK_0800.id.freeze

  jp_prefecture :prefecture_code

  # デフォルトの都道府県は東京都とする
  attribute :prefecture_code, :integer, default: JpPrefecture::Prefecture.find_code_by_name(DEFUALT_PREFECTURE_NAME)
  attribute :updatable_status_id, :integer, default: DEFUALT_UPDATABLE_STATUS.id
  attribute :remind_time_id, :integer, default: DEFUALT_REMIND_TIME

  belongs_to_active_hash :updatable_status
  belongs_to_active_hash :remind_time

  def transit_to_updated!
    update(updatable_status: UpdatableStatus::UPDATED)
  end

  def transit_to_prefecture_code_updatable!
    update(updatable_status: UpdatableStatus::PREFECTURE_CODE_UPDATABLE)
  end

  def transit_to_remind_time_updatable!
    update(updatable_status: UpdatableStatus::REMIND_TIME_UPDATABLE)
  end

  def updated?
    updatable_status == UpdatableStatus::UPDATED
  end

  def prefecture_code_updatable?
    updatable_status == UpdatableStatus::PREFECTURE_CODE_UPDATABLE
  end

  def remind_time_updatable?
    updatable_status == UpdatableStatus::REMIND_TIME_UPDATABLE
  end

  def update_prefecture(prefecture_code)
    update(prefecture_code: prefecture_code)
    transit_to_updated!
  end

  def update_remind_time(remind_time_id)
    update(remind_time_id: remind_time_id)
    transit_to_updated!
  end
end
