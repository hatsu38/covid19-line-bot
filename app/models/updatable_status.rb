class UpdatableStatus < ActiveYaml::Base
  include ActiveHash::Enum

  set_root_path "config/divisions"
  set_filename "updatable_status"

  enum_accessor :type
end