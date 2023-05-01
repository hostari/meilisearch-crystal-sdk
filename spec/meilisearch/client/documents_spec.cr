require "../../spec_helper"

describe MeiliSearch::Document do
  meilisearch_document = MeiliSearch::Document.new("test_key", "http://localhost:7700")

  it "gets all documents" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies/documents")
      .to_return(status: 200, body: File.read("spec/support/documents.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.list_all("movies")
    documents = response.body

    documents.should eq(File.read("spec/support/documents.json"))
  end

  it "gets one document" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies/documents/25864")
      .to_return(status: 200, body: File.read("spec/support/document_25864.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.list_one("movies", "25864")
    document = response.body

    document.should eq(File.read("spec/support/document_25864.json"))
  end

  it "adds or replaces documents" do
    WebMock.stub(:post, "http://localhost:7700/indexes/movies/documents")
      .with(body: [{"id" => 287947, "title" => "Shazam", "poster" => "https://image.tmdb.org/t/p/w1280/xnopI5Xtky18MPhK40cZAGAOVeV.jpg", "overview" => "A boy is given the ability to become an adult superhero in times of need with a single magic word.", "release_date" => "2019-03-23"}].to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: File.read("spec/support/replace_doc_287947.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.add_or_replace("movies", [{"id" => 287947, "title" => "Shazam", "poster" => "https://image.tmdb.org/t/p/w1280/xnopI5Xtky18MPhK40cZAGAOVeV.jpg", "overview" => "A boy is given the ability to become an adult superhero in times of need with a single magic word.", "release_date" => "2019-03-23"}])
    document = response.body

    document.should eq(File.read("spec/support/replace_doc_287947.json"))
  end

  it "adds or updated documents" do
    WebMock.stub(:post, "http://localhost:7700/indexes/movies/documents")
      .with(body: [{"id" => 287947, "title" => "Shazam ⚡️", "genres" => "comedy"}].to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: File.read("spec/support/update_doc_287947.json"), headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.add_or_replace("movies", [{"id" => 287947, "title" => "Shazam ⚡️", "genres" => "comedy"}])
    document = response.body

    document.should eq(File.read("spec/support/update_doc_287947.json"))
  end

  it "deletes all documents" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies/documents")
      .to_return(status: 204, headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.delete_all("movies")
    document = response.body

    document.should eq("")
  end

  it "deletes one document" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies/documents/25684")
      .to_return(status: 204, headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.delete("movies", "25684")
    document = response.body

    document.should eq("")
  end

  it "deletes documents by batch" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies/documents/delete-batch")
      .with(body: [23488, 153738, 437035, 363869].to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 204, headers: {"Content-Type" => "application/json"})

    response = meilisearch_document.delete_by_batch("movies", [23488, 153738, 437035, 363869])
    document = response.body

    document.should eq("")
  end
end
