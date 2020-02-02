# frozen_string_literal: true

tag 'simple-tag' do
  a 'simple', 'attribute'
  a 'with_data', basic_data_attribute
  a 'a_reference_attribute', nested_data[:just_a_value]
  a 'a_conditional_existing_reference_attribute', if: :a_conditional_existing_attribute, of: nested_data
  a 'a_conditional_non_existing_reference_attribute', if: :dont_expect_to_see_me, of: nested_data

  tag 'nested-tag' do
    a 'simple', 'attribute'
    a 'with_data', basic_data_attribute
    a 'a_reference_attribute', nested_data[:just_a_value]
    a 'a_conditional_existing_reference_attribute', if: :a_conditional_existing_attribute, of: nested_data
    a 'a_conditional_non_existing_reference_attribute', if: :dont_expect_to_see_me, of: nested_data
  end

  tag 'nested-conditional-existing-tag', if: :local_reference, of: nested_data do
    a 'simple', 'attribute'
    a 'with_data', local_reference[:local_data_attribute]
    a 'a_conditional_existing_reference_attribute', if: :another_conditional_existing_attribute, of: local_reference
    a 'a_conditional_non_existing_reference_attribute', if: :dont_expect_to_see_me_here_too, of: local_reference
  end

  tag 'nested-conditional-existing-tag-but-other-name', if: :local_reference, of: nested_data, as: :other_name do
    a 'simple', 'attribute'
    a 'with_data', other_name[:local_data_attribute]
    a 'a_conditional_existing_reference_attribute', if: :another_conditional_existing_attribute, of: other_name
    a 'a_conditional_non_existing_reference_attribute', if: :dont_expect_to_see_me_here_too, of: other_name
  end

  tag 'nested-conditional-absent-tag', if: :why_are_you_still_expecting_me, of: nested_data do
    a 'i_wont_be_rendered', 'attribute'
  end

  tag 'repeating-tag', collection: nested_data[:a_collection], as: :element do
    a 'simple', 'attribute'
    a 'with_data', element[:first_attribute]
    a 'existing_conditional', if: :conditional_attribute, of: element
    a 'non_existing_conditional', if: :you_should_talk_to_somebody, of: element

    tag 'with-a-nested-tag', if: element[:has_nested] do
      a 'simple', 'attribute'
      a 'with_data', element[:first_attribute]
    end
  end

  partial 'with_local_value', locals: { a_local_value: 'I am a local value' }
  partial 'with_global_value'
  partial 'as_a_collection', collection: nested_data[:a_collection], as: :element
end
