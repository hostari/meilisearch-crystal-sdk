require "../../spec_helper"

describe Meilisearch::Search do
  it "performs multiple search queries on one or more indexes by bundling them into a single HTTP request" do
    WebMock.stub(:post, "http://localhost:7700/multi-search")
      .to_return(status: 200, body: File.read("spec/support/multi_search.json"), headers: {"Content-Type" => "application/json"})

    response = Meilisearch::MultiSearch.search([{"indexUid" => "movies", "q" => "pooh", "limit" => 5}, {"indexUid" => "movies", "q" => "nemo", "limit" => 5}, {"indexUid" => "movie_ratings", "q" => "us"}])
    response.results.size.should eq(3)
  end
end
