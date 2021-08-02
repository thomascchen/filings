require 'rails_helper'

RSpec.describe "Receivers", type: :request do
  describe "GET #index" do
    let!(:receiverCA) { create(:receiver, ein: "123", state: "CA") }
    let!(:receiverNY) { create(:receiver, ein: "456", state: "NY") }

    context "when not filtering by state" do
      it "returns all receivers" do
        get "/receivers"

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(200)

        json_response = JSON.parse(response.body)

        expect(json_response["data"]).to contain_exactly(
          {
            "id" => receiverCA.id.to_s,
            "type" => "receivers",
            "attributes" => {
              "ein" => "123",
              "name"  => receiverCA.name,
              "street" => receiverCA.street,
              "city" => receiverCA.city,
              "state" => "CA",
              "zip" => receiverCA.zip
            }
          },
          {
            "id" => receiverNY.id.to_s,
            "type" => "receivers",
            "attributes" => {
              "ein" => "456",
              "name"  => receiverNY.name,
              "street" => receiverNY.street,
              "city" => receiverNY.city,
              "state" => "NY",
              "zip" => receiverNY.zip
            }
          }
        )
      end
    end

    context "when filtering by state" do
      it "returns only receivers in matching states" do
        get "/receivers", params: { state: "CA" }

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(200)

        json_response = JSON.parse(response.body)

        expect(json_response["data"]).to contain_exactly(
          {
            "id" => receiverCA.id.to_s,
            "type" => "receivers",
            "attributes" => {
              "ein" => "123",
              "name"  => receiverCA.name,
              "street" => receiverCA.street,
              "city" => receiverCA.city,
              "state" => "CA",
              "zip" => receiverCA.zip
            }
          }
        )
      end
    end

    it "handles errors"
  end
end
