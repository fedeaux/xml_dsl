tag 'too-lazy-to-add-new-examples' do
  a 'simple', 'attribute'
  a 'with_data', element[:first_attribute]
  a 'existing_conditional', if: :conditional_attribute, of: element
  a 'non_existing_conditional', if: :you_should_talk_to_somebody, of: element

  tag 'with-a-nested-tag', if: element[:has_nested] do
    a 'simple', 'attribute'
    a 'with_data', element[:first_attribute]
  end
end
