# AwesomeXmlDsl

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awesome_xml_dsl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install awesome_xml_dsl

## Usage

```ruby
data_source = {
  basic_data_attribute: 'I have a value',
  nested_data: {
    just_a_value: 'Me too',
    a_conditional_existing_attribute: 'Count on me',
    local_reference: {
      local_data_attribute: 'I have a value (Now in local reference)',
      another_conditional_existing_attribute: 'Count on me (Even in local reference)'
    },
    a_collection: [
      {
        first_attribute: 'First Attribute 1',
        conditional_attribute: 'Conditional Attribute 1',
        has_nested: true
      },
      {
        first_attribute: 'First Attribute 2',
        conditional_attribute: 'Conditional Attribute 2',
        has_nested: false
      },
      {
        first_attribute: 'First Attribute 3',
        conditional_attribute: 'Conditional Attribute 3',
        has_nested: false
      }
    ]
  }
}

AwesomeXmlDsl::Generator.new(data_source: data_source, template: 'template.xml.rb').generate
```

```ruby
# template.xml.rb

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
```

Generates:

```xml
<?xml version="1.0" encoding="utf-8"?>
<simple-tag
  simple="attribute"
  with_data="I have a value"
  a_reference_attribute="Me too"
  a_conditional_existing_reference_attribute="Count on me">
  <nested-tag
    simple="attribute"
    with_data="I have a value"
    a_reference_attribute="Me too"
    a_conditional_existing_reference_attribute="Count on me" />
  <nested-conditional-existing-tag
    simple="attribute"
    with_data="I have a value (Now in local reference)"
    a_conditional_existing_reference_attribute="Count on me (Even in local reference)" />
  <nested-conditional-existing-tag-but-other-name
    simple="attribute"
    with_data="I have a value (Now in local reference)"
    a_conditional_existing_reference_attribute="Count on me (Even in local reference)" />
  <repeating-tag
    simple="attribute"
    with_data="First Attribute 1"
    existing_conditional="Conditional Attribute 1">
    <with-a-nested-tag
      simple="attribute"
      with_data="First Attribute 1" />
  </repeating-tag>
  <repeating-tag
    simple="attribute"
    with_data="First Attribute 2"
    existing_conditional="Conditional Attribute 2" />
  <repeating-tag
    simple="attribute"
    with_data="First Attribute 3"
    existing_conditional="Conditional Attribute 3" />
  <partial_with_local_value nothing_that="fancy" />
  <i-am-not-sure if_that_should_be_allowed="I have a value" />
  <too-lazy-to-add-new-examples
    simple="attribute"
    with_data="First Attribute 1"
    existing_conditional="Conditional Attribute 1">
    <with-a-nested-tag
      simple="attribute"
      with_data="First Attribute 1" />
  </too-lazy-to-add-new-examples>
  <too-lazy-to-add-new-examples
    simple="attribute"
    with_data="First Attribute 2"
    existing_conditional="Conditional Attribute 2" />
  <too-lazy-to-add-new-examples
    simple="attribute"
    with_data="First Attribute 3"
    existing_conditional="Conditional Attribute 3" />
</simple-tag>
```
