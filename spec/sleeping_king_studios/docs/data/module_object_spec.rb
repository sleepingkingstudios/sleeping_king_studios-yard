# frozen_string_literal: true

require 'sleeping_king_studios/docs/data/module_object'

require 'support/contracts/data/base_contract'
require 'support/contracts/data/describable_contract'
require 'support/contracts/data/namespace_contract'
require 'support/fixtures'

RSpec.describe SleepingKingStudios::Docs::Data::ModuleObject do
  include Spec::Support::Contracts::Data
  include Spec::Support::Fixtures

  subject(:module_object) { described_class.new(native:) }

  include_context 'with fixture files', 'modules'

  let(:fixture)      { 'basic.rb' }
  let(:fixture_name) { 'Space' }
  let(:native) do
    YARD::Registry.find { |obj| obj.title == fixture_name }
  end

  def self.expected_json # rubocop:disable Metrics/MethodLength
    lambda do
      {
        'name'              => module_object.name,
        'slug'              => module_object.slug,
        'type'              => module_object.type,
        'files'             => module_object.files,
        'short_description' => module_object.short_description,
        'data_path'         => module_object.data_path,
        'parent_path'       => module_object.parent_path
      }
    end
  end

  include_contract('should be a data object',
    expected_json:)

  include_contract('should be a describable object',
    basic_name:    'Space',
    complex_name:  'SpaceAndTime',
    scoped_name:   'Cosmos::LocalDimension::SpaceAndTime',
    description:   'This module is out of this world.',
    expected_json:)

  include_contract('should implement the namespace methods',
    expected_json:)

  describe '#as_json' do
    let(:expected) { instance_exec(&self.class.expected_json) }

    wrap_context 'using fixture', 'with class scoped name' do
      let(:fixture_name) { 'Cosmos::Physics::SpaceAndTime' }

      it { expect(module_object.as_json).to be == expected }
    end

    wrap_context 'using fixture', 'with extended modules' do
      let(:expected) do
        super().merge(
          'class_attributes' => module_object.class_attributes,
          'class_methods'    => module_object.class_methods,
          'extended_modules' => module_object.extended_modules
        )
      end

      it { expect(module_object.as_json).to be == expected }
    end

    wrap_context 'using fixture', 'with included modules' do
      let(:expected) do
        super().merge(
          'constants'           => module_object.constants,
          'included_modules'    => module_object.included_modules,
          'instance_attributes' => module_object.instance_attributes,
          'instance_methods'    => module_object.instance_methods
        )
      end

      it { expect(module_object.as_json).to be == expected }
    end

    wrap_context 'using fixture', 'with scoped name' do
      let(:fixture_name) { 'Cosmos::LocalDimension::SpaceAndTime' }

      it { expect(module_object.as_json).to be == expected }
    end

    wrap_context 'using fixture', 'with everything' do
      let(:expected) do
        super().merge(
          'class_attributes'    => module_object.class_attributes,
          'class_methods'       => module_object.class_methods,
          'constants'           => module_object.constants,
          'defined_classes'     => module_object.defined_classes,
          'defined_modules'     => module_object.defined_modules,
          'description'         => module_object.description,
          'extended_modules'    => module_object.extended_modules,
          'included_modules'    => module_object.included_modules,
          'instance_attributes' => module_object.instance_attributes,
          'instance_methods'    => module_object.instance_methods,
          'metadata'            => module_object.metadata
        )
      end

      it { expect(module_object.as_json).to deep_match expected }
    end
  end

  describe '#extended_modules' do
    include_examples 'should define reader', :extended_modules, []

    wrap_context 'using fixture', 'with extended modules' do
      let(:expected) do
        [
          {
            'name' => 'Forwardable',
            'slug' => 'forwardable'
          },
          {
            'name' => 'Phenomena::WeatherEffects',
            'path' => 'phenomena/weather-effects',
            'slug' => 'weather-effects'
          },
          {
            'name' => 'Revenge',
            'path' => 'revenge',
            'slug' => 'revenge'
          }
        ]
      end

      it { expect(module_object.extended_modules).to be == expected }
    end

    wrap_context 'using fixture', 'with everything' do
      let(:expected) do
        [
          {
            'name' => 'Forwardable',
            'slug' => 'forwardable'
          },
          {
            'name' => 'Phenomena::WeatherEffects',
            'path' => 'phenomena/weather-effects',
            'slug' => 'weather-effects'
          },
          {
            'name' => 'Revenge',
            'path' => 'revenge',
            'slug' => 'revenge'
          }
        ]
      end

      it { expect(module_object.extended_modules).to be == expected }
    end
  end

  describe '#files' do
    let(:expected) { [File.join('spec/fixtures/modules', fixture)] }

    include_examples 'should define reader', :files, -> { expected }

    context 'when the module is defined in multiple files' do
      let(:expected) do
        [
          *super(),
          'spec/fixtures/modules/with_constants.rb',
          'spec/fixtures/modules/with_full_description.rb'
        ]
      end

      before(:example) do
        YARD.parse('spec/fixtures/modules/with_constants.rb')
        YARD.parse('spec/fixtures/modules/with_full_description.rb')
      end

      it { expect(module_object.files).to be == expected }
    end
  end

  describe '#included_modules' do
    include_examples 'should define reader', :included_modules, []

    wrap_context 'using fixture', 'with included modules' do
      let(:expected) do
        [
          {
            'name' => 'Comparable',
            'slug' => 'comparable'
          },
          {
            'name' => 'Dimensions',
            'slug' => 'dimensions',
            'path' => 'dimensions'
          },
          {
            'name' => 'Dimensions::HigherDimensions',
            'slug' => 'higher-dimensions',
            'path' => 'dimensions/higher-dimensions'
          }
        ]
      end

      it { expect(module_object.included_modules).to be == expected }
    end

    wrap_context 'using fixture', 'with everything' do
      let(:expected) do
        [
          {
            'name' => 'Comparable',
            'slug' => 'comparable'
          },
          {
            'name' => 'Dimensions',
            'slug' => 'dimensions',
            'path' => 'dimensions'
          },
          {
            'name' => 'Dimensions::HigherDimensions',
            'slug' => 'higher-dimensions',
            'path' => 'dimensions/higher-dimensions'
          }
        ]
      end

      it { expect(module_object.included_modules).to be == expected }
    end
  end

  describe '#parent_path' do
    include_examples 'should define reader', :parent_path, ''

    wrap_context 'using fixture', 'with class scoped name' do
      let(:fixture_name) { 'Cosmos::Physics::SpaceAndTime' }
      let(:expected)     { 'cosmos/physics' }

      it { expect(module_object.parent_path).to be == expected }
    end

    wrap_context 'using fixture', 'with scoped name' do
      let(:fixture_name) { 'Cosmos::LocalDimension::SpaceAndTime' }
      let(:expected)     { 'cosmos/local-dimension' }

      it { expect(module_object.parent_path).to be == expected }
    end

    wrap_context 'using fixture', 'with everything' do
      let(:expected) { '' }

      it { expect(module_object.parent_path).to be == expected }
    end
  end

  describe '#type' do
    include_examples 'should define reader', :type, 'module'
  end
end
