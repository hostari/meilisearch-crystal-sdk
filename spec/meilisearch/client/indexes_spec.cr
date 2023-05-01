require "../../spec_helper"

describe MeiliSearch::Index do
  meilisearch_index = MeiliSearch::Index.new("test_key", "http://localhost:7700")

  it "lists all indexes" do
    WebMock.stub(:get, "http://localhost:7700/indexes")
      .to_return(status: 200, body: File.read("spec/support/indexes.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.list_all
    indexes = response.body

    indexes.should eq(File.read("spec/support/indexes.json"))
  end

  it "lists all indexes with limit as a query parameter" do
    WebMock.stub(:get, "http://localhost:7700/indexes?limit=3")
      .to_return(status: 200, body: File.read("spec/support/indexes_limit3.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.list_all(limit: 3)
    limited_movies = response.body

    limited_movies.should eq(File.read("spec/support/indexes_limit3.json"))
  end

  it "gets information about a single index" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies")
      .to_return(status: 200, body: File.read("spec/support/movies_index.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.get_index("movies")
    movies = response.body

    movies.should eq(File.read("spec/support/movies_index.json"))
  end

  it "creates an index" do
    WebMock.stub(:post, "http://localhost:7700/indexes")
      .with(body: {uid: "movies", primary_key: "id"}.to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: File.read("spec/support/created_movie_index.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.create_index(uid: "movies", primary_key: "id")
    created_movie_index = response.body

    created_movie_index.should eq(File.read("spec/support/created_movie_index.json"))
  end

  it "updates an index's primary key" do
    WebMock.stub(:patch, "http://localhost:7700/indexes/movies")
      .with(body: {primary_key: "id"}.to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: File.read("spec/support/updated_movie_index.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.update_index(uid: "movies", primary_key: "id")
    updated_movie_index = response.body

    updated_movie_index.should eq(File.read("spec/support/updated_movie_index.json"))
  end

  it "deletes an index" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies")
      .to_return(status: 204, headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.delete_index(uid: "movies", primary_key: "id")
    updated_movie_index = response.body

    updated_movie_index.should eq("")
  end

  it "swaps an index" do
    WebMock.stub(:post, "http://localhost:7700/swap-indexes")
      .with(body: [{"indexes": ["indexA", "indexB"]}, {"indexes": ["indexX", "indexY"]}].to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, headers: {"Content-Type" => "application/json"})

    response = meilisearch_index.swap_indexes([{"indexes": ["indexA", "indexB"]}, {"indexes": ["indexX", "indexY"]}])
    updated_movie_index = response.body

    updated_movie_index.should eq("")
  end
end
