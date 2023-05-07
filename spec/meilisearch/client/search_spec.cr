require "../../spec_helper"

describe Meilisearch::Search do
  it "performs multiple search queries on one or more indexes by bundling them into a single HTTP request" do
    WebMock.stub(:post, "http://localhost:7700/indexes/movies/search")
      .to_return(status: 200, body: File.read("spec/support/search.json"), headers: {"Content-Type" => "application/json"})

    search_results = Meilisearch::Search.post_search(index_uid: "movies", q: "american ninja")
    search_results.hits.size.should eq(3)
  end
end
