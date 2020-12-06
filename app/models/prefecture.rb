class Prefecture < JpPrefecture::Prefecture
  alias id code

  def self.where(options)
    ids = Array(options[:id]).map(&:to_s).select(&:present?)
    all.select { |pref| ids.include?(pref.id.to_s) }.compact
  end
end
