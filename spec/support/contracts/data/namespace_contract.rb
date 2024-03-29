# frozen_string_literal: true

require 'rspec/sleeping_king_studios/contract'
require 'sleeping_king_studios/tools/toolbelt'

require 'support/contracts/data'

module Spec::Support::Contracts::Data
  class ShouldImplementTheNamespaceMethods
    extend RSpec::SleepingKingStudios::Contract

    # @!method apply(example_group)
    #   Adds the contract to the example group.
    #
    #   @param expected_json [Hash{String => Object}] the expected base response
    #     for #as_json.
    #   @param include_mixins [Boolean] if true, includes expected class and
    #     instance methods from extend-ed and include-ed modules.
    #   @param inherit_mixins [Boolean] if true, includes expected class and
    #     instance methods from inherited classes.
    contract do |expected_json:, include_mixins: true, inherit_mixins: false|
      let(:data_object) { subject }

      describe '#as_json' do
        let(:expected) { instance_exec(&expected_json) }

        it { expect(data_object).to respond_to(:as_json).with(0).arguments }

        it { expect(data_object.as_json).to be == expected }

        wrap_context 'using fixture', 'with class attributes' do
          let(:expected) do
            super().merge('class_attributes' => data_object.class_attributes)
          end

          it { expect(data_object.as_json).to be == expected }
        end

        wrap_context 'using fixture', 'with class methods' do
          let(:expected) do
            super().merge('class_methods' => data_object.class_methods)
          end

          it { expect(data_object.as_json).to be == expected }
        end

        wrap_context 'using fixture', 'with constants' do
          let(:expected) do
            super().merge('constants' => data_object.constants)
          end

          it { expect(data_object.as_json).to be == expected }
        end

        wrap_context 'using fixture', 'with defined classes' do
          let(:expected) do
            super().merge('defined_classes' => data_object.defined_classes)
          end

          it { expect(data_object.as_json).to be == expected }
        end

        wrap_context 'using fixture', 'with defined modules' do
          let(:expected) do
            super().merge('defined_modules' => data_object.defined_modules)
          end

          it { expect(data_object.as_json).to be == expected }
        end

        wrap_context 'using fixture', 'with instance attributes' do
          let(:expected) do
            super().merge(
              'instance_attributes' => data_object.instance_attributes
            )
          end

          it { expect(data_object.as_json).to be == expected }
        end

        wrap_context 'using fixture', 'with instance methods' do
          let(:expected) do
            super().merge('instance_methods' => data_object.instance_methods)
          end

          it { expect(data_object.as_json).to be == expected }
        end
      end

      describe '#class_attributes' do
        def relative_path(path)
          return path if data_object.name.empty? || data_object.name == 'root'

          "#{tools.str.underscore(data_object.name)}/#{path}"
        end

        include_examples 'should define reader', :class_attributes, []

        wrap_context 'using fixture', 'with class attributes' do
          let(:expected) do
            [
              {
                'name'      => 'gravity',
                'read'      => true,
                'write'     => false,
                'path'      => relative_path('c-gravity'),
                'slug'      => 'gravity',
                'inherited' => false
              },
              {
                'name'      => 'sandbox_mode',
                'read'      => true,
                'write'     => true,
                'path'      => relative_path('c-sandbox-mode'),
                'slug'      => 'sandbox-mode',
                'inherited' => false
              },
              {
                'name'      => 'secret_key',
                'read'      => false,
                'write'     => true,
                'path'      => relative_path('c-secret-key='),
                'slug'      => 'secret-key=',
                'inherited' => false
              }
            ]
          end

          it { expect(data_object.class_attributes).to be == expected }
        end

        if include_mixins
          wrap_context 'using fixture', 'with extended modules' do
            let(:expected) do
              [
                {
                  'name'      => 'pressure',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'phenomena/weather-effects/i-pressure',
                  'slug'      => 'pressure',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.class_attributes).to deep_match expected }
          end
        end

        if inherit_mixins
          wrap_context 'using fixture', 'with inherited classes' do
            let(:expected) do
              [
                {
                  'name'      => 'blueprints',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'engineering/c-blueprints',
                  'slug'      => 'blueprints',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.class_attributes).to deep_match expected }
          end
        end

        wrap_context 'using fixture', 'with everything' do
          let(:expected) do
            ary = [
              {
                'name'      => 'gravity',
                'read'      => true,
                'write'     => false,
                'path'      => relative_path('c-gravity'),
                'slug'      => 'gravity',
                'inherited' => false
              },
              {
                'name'      => 'sandbox_mode',
                'read'      => true,
                'write'     => true,
                'path'      => relative_path('c-sandbox-mode'),
                'slug'      => 'sandbox-mode',
                'inherited' => false
              },
              {
                'name'      => 'secret_key',
                'read'      => false,
                'write'     => true,
                'path'      => relative_path('c-secret-key='),
                'slug'      => 'secret-key=',
                'inherited' => false
              }
            ]

            if include_mixins
              ary += [
                {
                  'name'      => 'pressure',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'phenomena/weather-effects/i-pressure',
                  'slug'      => 'pressure',
                  'inherited' => true
                }
              ]
            end

            if inherit_mixins
              ary += [
                {
                  'name'      => 'blueprints',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'engineering/c-blueprints',
                  'slug'      => 'blueprints',
                  'inherited' => true
                }
              ]
            end

            ary.sort_by { |hsh| hsh['name'] }
          end

          it { expect(data_object.class_attributes).to be == expected }
        end
      end

      describe '#class_methods' do
        def relative_path(path)
          return path if data_object.name.empty? || data_object.name == 'root'

          "#{tools.str.underscore(data_object.name)}/#{path}"
        end

        include_examples 'should define reader', :class_methods, []

        wrap_context 'using fixture', 'with class methods' do
          let(:expected) do
            [
              {
                'name'      => 'calculate_isp',
                'path'      => relative_path('c-calculate-isp'),
                'slug'      => 'calculate-isp',
                'inherited' => false
              },
              {
                'name'      => 'plot_trajectory',
                'path'      => relative_path('c-plot-trajectory'),
                'slug'      => 'plot-trajectory',
                'inherited' => false
              }
            ]
          end

          it { expect(data_object.class_methods).to be == expected }
        end

        if include_mixins
          wrap_context 'using fixture', 'with extended modules' do
            let(:expected) do
              [
                {
                  'name'      => 'dew_point',
                  'path'      => 'atmosphere/i-dew-point',
                  'slug'      => 'dew-point',
                  'inherited' => true
                },
                {
                  'name'      => 'temperature',
                  'path'      => 'phenomena/weather-effects/i-temperature',
                  'slug'      => 'temperature',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.class_methods).to be == expected }
          end
        end

        if inherit_mixins
          wrap_context 'using fixture', 'with inherited classes' do
            let(:expected) do
              [
                {
                  'name'      => 'design',
                  'path'      => 'engineering/c-design',
                  'slug'      => 'design',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.class_methods).to be == expected }
          end
        end

        wrap_context 'using fixture', 'with everything' do
          let(:expected) do
            ary = [
              {
                'name'      => 'calculate_isp',
                'path'      => relative_path('c-calculate-isp'),
                'slug'      => 'calculate-isp',
                'inherited' => false
              },
              {
                'name'      => 'plot_trajectory',
                'path'      => relative_path('c-plot-trajectory'),
                'slug'      => 'plot-trajectory',
                'inherited' => false
              }
            ]

            if include_mixins
              ary += [
                {
                  'name'      => 'dew_point',
                  'path'      => 'atmosphere/i-dew-point',
                  'slug'      => 'dew-point',
                  'inherited' => true
                },
                {
                  'name'      => 'temperature',
                  'path'      => 'phenomena/weather-effects/i-temperature',
                  'slug'      => 'temperature',
                  'inherited' => true
                }
              ]
            end

            if inherit_mixins
              ary += [
                {
                  'name'      => 'design',
                  'path'      => 'engineering/c-design',
                  'slug'      => 'design',
                  'inherited' => true
                }
              ]
            end

            ary.sort_by { |hsh| hsh['name'] }
          end

          it { expect(data_object.class_methods).to be == expected }
        end
      end

      describe '#constants' do
        include_examples 'should define reader', :constants, []

        wrap_context 'using fixture', 'with constants' do
          let(:base_path) do
            return '' unless data_object.respond_to?(:data_path)

            return '' if data_object.data_path == 'root'

            "#{data_object.data_path}/"
          end
          let(:expected) do
            [
              {
                'name'      => 'ELDRITCH',
                'path'      => "#{base_path}eldritch",
                'slug'      => 'eldritch',
                'inherited' => false
              },
              {
                'name'      => 'SQUAMOUS',
                'path'      => "#{base_path}squamous",
                'slug'      => 'squamous',
                'inherited' => false
              }
            ]
          end

          it { expect(data_object.constants).to be == expected }
        end

        if include_mixins
          wrap_context 'using fixture', 'with included modules' do
            let(:expected) do
              [
                {
                  'name'      => 'LENGTH',
                  'path'      => 'dimensions/length',
                  'slug'      => 'length',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.constants).to be == expected }
          end
        end

        if inherit_mixins
          wrap_context 'using fixture', 'with inherited classes' do
            let(:expected) do
              [
                {
                  'name'      => 'MODEL',
                  'path'      => 'physics/rocket-science/model',
                  'slug'      => 'model',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.constants).to be == expected }
          end
        end

        wrap_context 'using fixture', 'with everything' do
          let(:base_path) do
            return '' unless data_object.respond_to?(:data_path)

            return '' if data_object.data_path == 'root'

            "#{data_object.data_path}/"
          end
          let(:expected) do
            ary = [
              {
                'name'      => 'ELDRITCH',
                'path'      => "#{base_path}eldritch",
                'slug'      => 'eldritch',
                'inherited' => false
              },
              {
                'name'      => 'SQUAMOUS',
                'path'      => "#{base_path}squamous",
                'slug'      => 'squamous',
                'inherited' => false
              }
            ]

            if include_mixins
              ary += [
                {
                  'name'      => 'LENGTH',
                  'path'      => 'dimensions/length',
                  'slug'      => 'length',
                  'inherited' => true
                }
              ]
            end

            if inherit_mixins
              ary += [
                {
                  'name'      => 'MODEL',
                  'path'      => 'physics/rocket-science/model',
                  'slug'      => 'model',
                  'inherited' => true
                }
              ]
            end

            ary.sort_by { |hsh| hsh['name'] }
          end

          it { expect(data_object.constants).to be == expected }
        end
      end

      describe '#defined_classes' do
        include_examples 'should define reader', :defined_classes, []

        wrap_context 'using fixture', 'with defined classes' do
          let(:expected) do
            [
              {
                'name' => 'FuelTank',
                'slug' => 'fuel-tank'
              },
              {
                'name' => 'Part',
                'slug' => 'part'
              },
              {
                'name' => 'Rocket',
                'slug' => 'rocket'
              }
            ]
          end

          it { expect(data_object.defined_classes).to be == expected }
        end

        wrap_context 'using fixture', 'with everything' do
          let(:expected) do
            [
              {
                'name' => 'FuelTank',
                'slug' => 'fuel-tank'
              },
              {
                'name' => 'Part',
                'slug' => 'part'
              },
              {
                'name' => 'Rocket',
                'slug' => 'rocket'
              }
            ]
          end

          it { expect(data_object.defined_classes).to be == expected }
        end
      end

      describe '#defined_modules' do
        include_examples 'should define reader', :defined_modules, []

        wrap_context 'using fixture', 'with defined modules' do
          let(:expected) do
            [
              {
                'name' => 'Alchemy',
                'slug' => 'alchemy'
              },
              {
                'name' => 'Clockwork',
                'slug' => 'clockwork'
              },
              {
                'name' => 'ShadowMagic',
                'slug' => 'shadow-magic'
              }
            ]
          end

          it { expect(data_object.defined_modules).to be == expected }
        end

        wrap_context 'using fixture', 'with everything' do
          let(:expected) do
            [
              {
                'name' => 'Alchemy',
                'slug' => 'alchemy'
              },
              {
                'name' => 'Clockwork',
                'slug' => 'clockwork'
              },
              {
                'name' => 'ShadowMagic',
                'slug' => 'shadow-magic'
              }
            ]
          end

          it { expect(data_object.defined_modules).to be == expected }
        end
      end

      describe '#instance_attributes' do
        def relative_path(path)
          return path if data_object.name.empty? || data_object.name == 'root'

          "#{tools.str.underscore(data_object.name)}/#{path}"
        end

        include_examples 'should define reader', :instance_attributes, []

        if include_mixins
          wrap_context 'using fixture', 'with included modules' do
            let(:expected) do
              [
                {
                  'name'      => 'depth',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'measurement/i-depth',
                  'slug'      => 'depth',
                  'inherited' => true
                },
                {
                  'name'      => 'height',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'measurement/i-height',
                  'slug'      => 'height',
                  'inherited' => true
                },
                {
                  'name'      => 'width',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'measurement/i-width',
                  'slug'      => 'width',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.instance_attributes).to be == expected }
          end
        end

        if inherit_mixins
          wrap_context 'using fixture', 'with inherited classes' do
            let(:expected) do
              [
                {
                  'name'      => 'difficulty',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'physics/rocket-science/i-difficulty',
                  'slug'      => 'difficulty',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.instance_attributes).to be == expected }
          end
        end

        wrap_context 'using fixture', 'with instance attributes' do
          let(:expected) do
            [
              {
                'name'      => 'base_mana',
                'read'      => true,
                'write'     => false,
                'path'      => relative_path('i-base-mana'),
                'slug'      => 'base-mana',
                'inherited' => false
              },
              {
                'name'      => 'magic_enabled',
                'read'      => true,
                'write'     => true,
                'path'      => relative_path('i-magic-enabled'),
                'slug'      => 'magic-enabled',
                'inherited' => false
              },
              {
                'name'      => 'secret_formula',
                'read'      => false,
                'write'     => true,
                'path'      => relative_path('i-secret-formula='),
                'slug'      => 'secret-formula=',
                'inherited' => false
              }
            ]
          end

          it { expect(data_object.instance_attributes).to be == expected }
        end

        wrap_context 'using fixture', 'with everything' do
          let(:expected) do
            ary = [
              {
                'name'      => 'base_mana',
                'read'      => true,
                'write'     => false,
                'path'      => relative_path('i-base-mana'),
                'slug'      => 'base-mana',
                'inherited' => false
              },
              {
                'name'      => 'magic_enabled',
                'read'      => true,
                'write'     => true,
                'path'      => relative_path('i-magic-enabled'),
                'slug'      => 'magic-enabled',
                'inherited' => false
              },
              {
                'name'      => 'secret_formula',
                'read'      => false,
                'write'     => true,
                'path'      => relative_path('i-secret-formula='),
                'slug'      => 'secret-formula=',
                'inherited' => false
              }
            ]

            if include_mixins
              ary += [
                {
                  'name'      => 'depth',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'measurement/i-depth',
                  'slug'      => 'depth',
                  'inherited' => true
                },
                {
                  'name'      => 'height',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'measurement/i-height',
                  'slug'      => 'height',
                  'inherited' => true
                },
                {
                  'name'      => 'width',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'measurement/i-width',
                  'slug'      => 'width',
                  'inherited' => true
                }
              ]
            end

            if inherit_mixins
              ary += [
                {
                  'name'      => 'difficulty',
                  'read'      => true,
                  'write'     => true,
                  'path'      => 'physics/rocket-science/i-difficulty',
                  'slug'      => 'difficulty',
                  'inherited' => true
                }
              ]
            end

            ary.sort_by { |hsh| hsh['name'] }
          end

          it { expect(data_object.instance_attributes).to be == expected }
        end
      end

      describe '#instance_methods' do
        def relative_path(path)
          return path if data_object.name.empty? || data_object.name == 'root'

          "#{tools.str.underscore(data_object.name)}/#{path}"
        end

        include_examples 'should define reader', :instance_methods, []

        if include_mixins
          wrap_context 'using fixture', 'with included modules' do
            let(:expected) do
              [
                {
                  'name'      => 'cardinality',
                  'path'      => 'dimensions/i-cardinality',
                  'slug'      => 'cardinality',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.instance_methods).to be == expected }
          end
        end

        if inherit_mixins
          wrap_context 'using fixture', 'with constructor' do
            let(:expected) do
              [
                {
                  'name'        => 'initialize',
                  'path'        => relative_path('i-initialize'),
                  'slug'        => 'initialize',
                  'constructor' => true,
                  'inherited'   => false
                }
              ]
            end

            it { expect(data_object.instance_methods).to be == expected }
          end

          wrap_context 'using fixture', 'with inherited constructor' do
            let(:expected) do
              [
                {
                  'name'        => 'initialize',
                  'path'        => 'rocket-science/i-initialize',
                  'slug'        => 'initialize',
                  'constructor' => true,
                  'inherited'   => true
                }
              ]
            end

            it { expect(data_object.instance_methods).to be == expected }
          end

          wrap_context 'using fixture', 'with inherited classes' do
            let(:expected) do
              [
                {
                  'name'      => 'project_orion',
                  'path'      => 'physics/rocket-science/i-project-orion',
                  'slug'      => 'project-orion',
                  'inherited' => true
                }
              ]
            end

            it { expect(data_object.instance_methods).to be == expected }
          end
        end

        wrap_context 'using fixture', 'with instance methods' do
          let(:expected) do
            [
              {
                'name'      => 'convert_mana',
                'path'      => relative_path('i-convert-mana'),
                'slug'      => 'convert-mana',
                'inherited' => false
              },
              {
                'name'      => 'summon_dark_lord',
                'path'      => relative_path('i-summon-dark-lord'),
                'slug'      => 'summon-dark-lord',
                'inherited' => false
              }
            ]
          end

          it { expect(data_object.instance_methods).to be == expected }
        end

        wrap_context 'using fixture', 'with everything' do
          let(:expected) do
            ary = [
              {
                'name'      => 'convert_mana',
                'path'      => relative_path('i-convert-mana'),
                'slug'      => 'convert-mana',
                'inherited' => false
              },
              {
                'name'      => 'summon_dark_lord',
                'path'      => relative_path('i-summon-dark-lord'),
                'slug'      => 'summon-dark-lord',
                'inherited' => false
              }
            ]

            if include_mixins
              ary += [
                {
                  'name'      => 'cardinality',
                  'path'      => 'dimensions/i-cardinality',
                  'slug'      => 'cardinality',
                  'inherited' => true
                }
              ]
            end

            if inherit_mixins
              ary += [
                {
                  'name'        => 'initialize',
                  'path'        => 'rocketry/i-initialize',
                  'slug'        => 'initialize',
                  'constructor' => true,
                  'inherited'   => false
                },
                {
                  'name'      => 'project_orion',
                  'path'      => 'physics/rocket-science/i-project-orion',
                  'slug'      => 'project-orion',
                  'inherited' => true
                }
              ]
            end

            ary.sort_by { |hsh| hsh['name'] }
          end

          it { expect(data_object.instance_methods).to be == expected }
        end
      end
    end
  end
end
