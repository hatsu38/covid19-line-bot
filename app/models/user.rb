# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  line_id         :string           not null
#  prefecture_code :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  DEFUALT_PREFECTURE = "東京都"

  # デフォルトの都道府県は東京都とする
  attribute :prefecture_code, :integer, default: Prefecture.find_code_by_name(DEFUALT_PREFECTURE)
  include JpPrefecture

  jp_prefecture :prefecture_code
end
