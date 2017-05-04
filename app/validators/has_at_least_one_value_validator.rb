class HasAtLeastOneValueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _parameters)
    values = record.send(attribute).values
    return unless values.blank?

    record.errors[attribute] << 'musi mieć przynajmniej jedną wartość'
  end
end
