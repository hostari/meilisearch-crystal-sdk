require "../../spec_helper"

describe MeiliSearch::Search do
  meilisearch_index = MeiliSearch::Search.new("test_key", "http://localhost:7700")

  it "searches for documents matching a specific query in the given index" do
    WebMock.stub(:post, "http://localhost:7700/indexes/movies/search")
      .with(body: {"q": "american ninja"}.to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: File.read("spec/support/search.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.search(index_uid: "movies", keyword: "american ninja")
    created_movie_index = response.body

    created_movie_index.should eq(File.read("spec/support/search.json"))
  end

  it "performs multiple search queries on one or more indexes by bundling them into a single HTTP request" do
    WebMock.stub(:post, "http://localhost:7700/multi-search")
      .with(body: {"queries": [{"indexUid": "movies", "q": "pooh", "limit": 5}, {"indexUid": "movies", "q": "nemo", "limit": 5}, {"indexUid": "movie_ratings", "q": "us"}]}.to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: File.read("spec/support/multi_search.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.multi_search(queries: [{"indexUid" => "movies", "q" => "pooh", "limit" => 5}, {"indexUid" => "movies", "q" => "nemo", "limit" => 5}, {"indexUid" => "movie_ratings", "q" => "us"}])
    created_movie_index = response.body

    created_movie_index.should eq(File.read("spec/support/multi_search.json"))
  end
end
