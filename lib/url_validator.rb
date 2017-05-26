class UrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    return true if value.blank?

    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless self.class.compliant?(value)
      record.errors.add(
        attribute,
        'is not a valid HTTP(S) URL, should include http(s)://'
      )
    end
  end
end
