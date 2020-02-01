# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe 'Generating the phylogenetic tree for primates' do
  let(:monkeys) do
    {
      children: [
        {
          name: 'Simão',
          picture: 'nem tem',
          children: [
            {
              name: 'Macaco bom'
            }
          ]
        }
      ]
    }
  end

  describe 'the generated xml' do
    it 'generates the xml' do
      puts XmlDsl::Generator.new(data_source: monkeys,
                                 template: File.join(XmlDsl.root, 'examples/templates/phylogenetic_tree/index.xml.rb')).generate
    end
  end
end
