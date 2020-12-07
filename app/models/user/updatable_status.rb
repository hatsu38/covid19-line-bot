class User::UpdatableStatus < ActiveYaml::Base
  include ActiveHash::Enum

  set_root_path "config/divisions"
  set_filename "user_updatable_status"

  enum_accessor :type
end