class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def text_field_with_validation(attribute, options = {})
    field_with_validation(:text_field, attribute, options)
  end

  def password_field_with_validation(attribute, options = {})
    field_with_validation(:password_field, attribute, options)
  end

  private

  def field_with_validation(field_type, attribute, options)
    field = send(field_type, attribute, options)
    error = @object.errors.to_hash[attribute]&.to_sentence
    @template.content_tag(
      :div,
      (
        @template.content_tag(
          :div,
          label(attribute) + field,
          class: "label-input-container"
        ) +
        @template.content_tag(
          :div,
          error,
          class: "validation-message"
        )
      ),
      class: "form-group"
    )
  end
end