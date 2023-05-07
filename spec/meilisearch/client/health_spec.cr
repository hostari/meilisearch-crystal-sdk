require "../../spec_helper"

describe Meilisearch::Health do
  it "gets the health of Meilisearch server" do
    WebMock.stub(:get, "http://localhost:7700/health")
      .to_return(status: 200, body: File.read("spec/support/health.json"), headers: {"Content-Type" => "application/json"})

    health = Meilisearch::Health.retrieve_health
    health.status.should eq("available")
  end
end
