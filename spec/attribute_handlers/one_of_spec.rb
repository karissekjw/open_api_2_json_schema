RSpec.describe OpenApi2JsonSchema::AttributeHandlers::OneOf do
  subject { described_class.new.call(one_of_schemas) }

  context "when schema is valid" do
    let(:one_of_schemas) do
      [
        {
          "key" => "value",
          "schema" => { "$ref" => "/path-to-file#/schema" }
        }
      ]
    end
    let(:expected_result) do
      [
        {
          "key" => "value",
          "schema" => {
            'type' => "object"
          }
        }
      ]
    end

    before do
      expect(OpenApi2JsonSchema::RefSchemaParser).to receive_message_chain(:new, :call)
        .with("/path-to-file#/schema")
        .and_return({ "type" => "object" })
    end

    it { expect(subject).to eq(expected_result) }
  end
end
