require "../../spec_helper"

describe Meilisearch::Stats do
  it "gets stats of all indexes." do
    WebMock.stub(:get, "http://localhost:7700/stats")
      .to_return(status: 200, body: File.read("spec/support/stats.json"), headers: {"Content-Type" => "application/json"})

    response = Meilisearch::Stats.list_stats
    response.databaseSize.should eq(447819776)
  end

  it "gets stats of an index." do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies/stats")
      .to_return(status: 200, body: File.read("spec/support/stat_1.json"), headers: {"Content-Type" => "application/json"})

    response = Meilisearch::Stats.retrieve_stat("movies")
    response.numberOfDocuments.should eq(19654)
  end
end
