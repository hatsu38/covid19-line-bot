class RemindTime < ActiveYaml::Base
  include ActiveHash::Enum

  set_root_path "config/divisions"
  set_filename "remind_time"

  enum_accessor :type

  def self.find_time(time)
    find_by(name_24: time) || find_by(name_12: time) ||
      find_by(name_en_12: time) || find_by(time: time) || find_by(time_easy: time)
  end
end
