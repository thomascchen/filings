require 'rails_helper'

RSpec.describe "Filings", type: :request do
  describe "GET #index" do
    it "returns filings" do
      filer1 = create(:filer, name: "Cool Filer 1")
      filing1 = create(:filing, tax_year: 2021, filer: filer1)
      receiver1 = create(:receiver, name: "Cool Receiver 1")
      award1 = create(:award, filing: filing1, receiver: receiver1)

      filer2 = create(:filer, name: "Cool Filer 2")
      filing2 = create(:filing, tax_year: 2020, filer: filer2)
      receiver2 = create(:receiver, name: "Cool Receiver 2")
      award2 = create(:award, filing: filing2, receiver: receiver2)

      get "/filings"

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response["data"]).to contain_exactly(
        {
          "id" => filing1.id.to_s,
          "type" => "filings",
          "attributes" => {
            "tax_year" => 2021,
            "amended" => filing1.amended
          },
          "relationships" => {
            "awards" => {
              "data" => [
                {
                  "id" => award1.id.to_s,
                  "type" => "awards"
                }
              ]
            },
            "filer" => {
              "data" => {
                "id" => filer1.id.to_s,
                "type" => "filers"
              }
            }
          }
        },
        {
          "id" => filing2.id.to_s,
          "type" => "filings",
          "attributes" => {
            "tax_year" => 2020,
            "amended" => filing2.amended
          },
          "relationships" => {
            "awards" => {
              "data" => [
                {
                  "id" => award2.id.to_s,
                  "type" => "awards"
                }
              ]
            },
            "filer" => {
              "data" => {
                "id" => filer2.id.to_s,
                "type" => "filers"
              }
            }
          }
        }
      )

      expect(json_response["included"]).to contain_exactly(
        {
          "id" => filer1.id.to_s,
          "type" => "filers",
          "attributes" => {
            "ein" => filer1.ein,
            "name" => "Cool Filer 1",
            "street" => filer1.street,
            "city" => filer1.city,
            "state" => filer1.state,
            "zip" => filer1.zip
          }
        },
        {
          "id" => filer2.id.to_s,
          "type" => "filers",
          "attributes" => {
            "ein" => filer2.ein,
            "name" => "Cool Filer 2",
            "street" => filer2.street,
            "city" => filer2.city,
            "state" => filer2.state,
            "zip" => filer2.zip
          }
        },
        {
          "id" => receiver1.id.to_s,
          "type" => "receivers",
          "attributes" => {
            "ein" => receiver1.ein,
            "name" => "Cool Receiver 1",
            "street" => receiver1.street,
            "city" => receiver1.city,
            "state" => receiver1.state,
            "zip" => receiver1.zip
          }
        },
        {
          "id" => receiver2.id.to_s,
          "type" => "receivers",
          "attributes" => {
            "ein" => receiver2.ein,
            "name" => "Cool Receiver 2",
            "street" => receiver2.street,
            "city" => receiver2.city,
            "state" => receiver2.state,
            "zip" => receiver2.zip
          }
        },
        {
          "id" => award1.id.to_s,
          "type" => "awards",
          "attributes" => {
            "cash_amount" => award1.cash_amount,
            "purpose" => award1.purpose
          },
          "relationships" => {
            "receiver" => { 
              "data" => {
                "id" => receiver1.id.to_s,
                "type" => "receivers",
              }
            } 
          }
        },
        {
          "id" => award2.id.to_s,
          "type" => "awards",
          "attributes" => {
            "cash_amount" => award2.cash_amount,
            "purpose" => award2.purpose
          },
          "relationships" => {
            "receiver" => { 
              "data" => {
                "id" => receiver2.id.to_s,
                "type" => "receivers",
              }
            } 
          }
        }
      )
    end
  end
end
