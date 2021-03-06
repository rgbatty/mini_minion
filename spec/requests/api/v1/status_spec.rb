require 'rails_helper'

describe "Status Endpoint" do
  it "Sends status information for the server" do
    status = create(:status, version: "0.0.1")
    formatted_created_at = status.created_at.strftime("%m/%d/%Y at %I:%M%p")

    get "/api/v1/status"

    expect(response).to be_success

    parsed_status = JSON.parse(response.body)

    expect(parsed_status["version"]).to eq "0.0.1"
    expect(parsed_status["last_update"]).to eq formatted_created_at
  end

  it "pulls the newest status information" do
    status = create(:status, version: "0.0.1", created_at: "2012-03-27T14:53:59.000Z")
    newer_status = create(:status, version: "0.0.2")

    get "/api/v1/status"

    expect(response).to be_success

    parsed_status = JSON.parse(response.body)

    expect(parsed_status["version"]).to eq "0.0.2"
  end
end
