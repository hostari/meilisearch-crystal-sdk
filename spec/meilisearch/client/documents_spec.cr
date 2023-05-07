require "../../spec_helper"

describe Meilisearch::Document do
  it "gets all documents" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies/documents")
      .to_return(status: 200, body: File.read("spec/support/documents.json"), headers: {"Content-Type" => "application/json"})

    documents = Meilisearch::Document.list_with_index_uid("movies")
    documents.first.id.should eq(25684)
  end

  it "gets one document" do
    WebMock.stub(:get, "http://localhost:7700/indexes/movies/documents/25684")
      .to_return(status: 200, body: File.read("spec/support/document_25864.json"), headers: {"Content-Type" => "application/json"})

    document = Meilisearch::Document.retrieve_with_index_uid("movies", 25684)
    document.id.should eq(25684)
  end

  it "adds or replaces documents" do
    WebMock.stub(:post, "http://localhost:7700/indexes/movies/documents")
      .to_return(status: 200, body: File.read("spec/support/replace_doc_287947.json"), headers: {"Content-Type" => "application/json"})

    added_or_replaced_docs = Meilisearch::Document.add_or_replace("movies", [{"id" => 287947, "title" => "Shazam", "poster" => "https://image.tmdb.org/t/p/w1280/xnopI5Xtky18MPhK40cZAGAOVeV.jpg", "overview" => "A boy is given the ability to become an adult superhero in times of need with a single magic word.", "release_date" => "2019-03-23"}])
    added_or_replaced_docs.taskUid.should eq(23)
  end

  it "adds or updates documents" do
    WebMock.stub(:put, "http://localhost:7700/indexes/movies/documents")
      .to_return(status: 200, body: File.read("spec/support/update_doc_287947.json"), headers: {"Content-Type" => "application/json"})

    added_or_updated_docs = Meilisearch::Document.add_or_update("movies", [{"id" => 287947, "title" => "Shazam", "poster" => "https://image.tmdb.org/t/p/w1280/xnopI5Xtky18MPhK40cZAGAOVeV.jpg", "overview" => "A boy is given the ability to become an adult superhero in times of need with a single magic word.", "release_date" => "2019-03-23"}])
    added_or_updated_docs.taskUid.should eq(245)
  end

  it "deletes all documents" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies/documents")
      .to_return(status: 202, body: "", headers: {"Content-Type" => "application/json"})

    deleted_documents = Meilisearch::Document.delete_all("movies")
    deleted_documents.should eq(true)
  end

  it "deletes one document" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies/documents/25684")
      .to_return(status: 202, body: "", headers: {"Content-Type" => "application/json"})

    deleted_document = Meilisearch::Document.delete_single_document("movies", 25684)
    deleted_document.should eq(true)
  end

  it "deletes documents by batch" do
    WebMock.stub(:delete, "http://localhost:7700/indexes/movies/documents/delete-batch")
      .to_return(status: 202, body: "", headers: {"Content-Type" => "application/json"})

    deleted_batch = Meilisearch::Document.delete_by_batch("movies", [23488, 153738, 437035, 363869])
    deleted_batch.should eq(true)
  end
end
