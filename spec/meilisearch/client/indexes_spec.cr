require "../../spec_helper"

describe Meilisearch::Index do
  it "lists all indexes" do
    WebMock.stub(:get, "http://localhost:7700/indexes")
      .to_return(status: 200, body: File.read("spec/support/indexes.json"), headers: {"Content-Type" => "application/json"})

    indexes = Meilisearch::Index.list
    indexes.first.uid.should eq("books")
    indexes.first.primaryKey.should eq("id")
    indexes.first.createdAt.should eq("2022-03-08T10:00:27.377346Z")
    indexes.first.updatedAt.should eq("2022-03-08T10:00:27.391209Z")
  end

  it "retrieves a single index" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies")
      .to_return(status: 200, body: File.read("spec/support/indexes_movies.json"), headers: {"Content-Type" => "application/json"})

    index = Meilisearch::Index.retrieve("movies")
    index.uid.should eq("movies")
  end

  it "creates an index" do
    WebMock.stub(:post, "http://localhost:7700/indexes")
      .to_return(status: 200, body: File.read("spec/support/indexes_beverages_post.json"), headers: {"Content-Type" => "application/json"})

    index = Meilisearch::Index.create(uid: "beverages", primaryKey: "id")
    index.indexUid.should eq("beverages")

    WebMock.stub(:get, "http://localhost:7700/indexes/beverages")
      .to_return(status: 200, body: File.read("spec/support/indexes_beverages.json"), headers: {"Content-Type" => "application/json"})

    beverages = Meilisearch::Index.retrieve("beverages")
    beverages.primaryKey.should eq("id")
    beverages.createdAt.should eq("2022-10-10T07:45:15.628261Z")
    beverages.updatedAt.should eq("2022-10-21T15:28:43.496574Z")
  end

  it "updates an index's primary key" do
    WebMock.stub(:patch, "http://localhost:7700/indexes/beverages")
      .to_return(status: 200, body: File.read("spec/support/updated_movie_index.json"), headers: {"Content-Type" => "application/json"})

    index = Meilisearch::Index.update(index: "beverages", primaryKey: "reference_code")
    index.taskUid.should eq(106)
  end

  it "deletes an index" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/articles")
      .to_return(status: 202, body: "", headers: {"Content-Type" => "application/json"})

    index = Meilisearch::Index.delete("articles")
    index.should eq(true)
  end

  it "swaps an index" do
    WebMock.stub(:post, "http://localhost:7700/swap-indexes")
      .to_return(status: 200, body: File.read("spec/support/indexes_swapped.json"), headers: {"Content-Type" => "application/json"})

    swapped_indexes = Meilisearch::Index.swap_indexes([{"indexes": ["movies", "movies_new"]}])
    swapped_indexes.type.should eq(Meilisearch::Task::Type::IndexSwap)
  end
end
