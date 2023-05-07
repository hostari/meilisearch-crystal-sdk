require "./spec_helper"

describe Meilisearch do
  it "sets api_key" do
    Meilisearch.master_key = "test"
    Meilisearch.master_key.should eq("test")
  end

  it "set base_url" do
    Meilisearch.base_url = "http://localhost:7700"
    Meilisearch.base_url.should eq("http://localhost:7700")
  end

  #   it "set version" do
  #     Meilisearch.version = "2020-04-02"
  #     Meilisearch.version.should eq("2020-04-02")
  #   end

  it "get client" do
    Meilisearch.client.class.name.should eq("HTTP::Client")
  end
end
