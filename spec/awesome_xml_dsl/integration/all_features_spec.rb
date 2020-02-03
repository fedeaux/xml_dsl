# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe 'Generating xmls with all features' do
  describe 'the generated xml' do
    let(:data_source) do
      {
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
    end

    it 'generates the xml' do
      template = File.join(AwesomeXmlDsl.root, 'examples/templates/all_features/index.xml.rb')
      expected_xml = File.read(File.join(AwesomeXmlDsl.root, 'examples/xmls/all_features/index.xml'))

      expect(AwesomeXmlDsl::Generator.new(data_source: data_source,
                                   template: template).generate).to eq expected_xml
    end
  end

  describe 'a required attribute' do
    let(:data_source) do
      {
        i_dont: {
          have: :it
        }
      }
    end

    it 'raises an error if the require value is not present' do
      template = File.join(AwesomeXmlDsl.root, 'examples/templates/other_features/required_value.xml.rb')

      expect do
        AwesomeXmlDsl::Generator.new(data_source: data_source,
                              template: template).generate
      end.to raise_error(AwesomeXmlDsl::RequiredValueNotPresent, "Can't read required key inexistent of i_dont")
    end
  end
end
