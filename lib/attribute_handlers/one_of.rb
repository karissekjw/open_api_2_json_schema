require_relative "../ref_schema_parser"

module OpenApi2JsonSchema
  module AttributeHandlers
    class OneOf
      def call(one_of_schemas)
        raise "oneOf schema must be an Array" unless one_of_schemas.is_a?(Array)

        one_of_schemas.map do |schema|
          subschema = schema["schema"]
          if subschema["$ref"]
            schema["schema"] = OpenApi2JsonSchema::RefSchemaParser.new.call(subschema["$ref"])
          end
        end

        one_of_schemas
      end
    end
  end
end
