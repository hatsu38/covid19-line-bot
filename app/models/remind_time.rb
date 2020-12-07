class RemindTime < ActiveYaml::Base
  include ActiveHash::Enum

  set_root_path "config/divisions"
  set_filename "remind_time"

  enum_accessor :type
end