require "../../spec_helper"

describe Meilisearch::Settings do
  it "gets the settings of an index" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies/settings")
      .to_return(status: 200, body: File.read("spec/support/get_settings.json"), headers: {"Content-Type" => "application/json"})

    settings = Meilisearch::Settings.retrieve_settings("movies")
    settings.searchableAttributes.should eq(["*"])
  end
end
