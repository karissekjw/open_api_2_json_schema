require_relative '../ref_schema_parser'

module OpenApi2JsonSchema
  module AttributeHandlers
    class OneOf
      def call(one_of_schemas)
        raise 'oneOf schema must be an Array' unless one_of_schemas.is_a?(Array)

        one_of_schemas.map do |schema|
          subschema = schema['schema']
          if subschema['$ref']
            subschema = OpenApi2JsonSchema::RefSchemaParser.new.call(value['$ref'])
            schema['schema'] = subschema['schema']
          end
        end
      end
    end
  end
end
