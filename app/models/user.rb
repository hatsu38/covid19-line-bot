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
  include JpPrefecture

  jp_prefecture :prefecture_code
end
