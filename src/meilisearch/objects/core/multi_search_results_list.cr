class Meilisearch::MultiSearchResults
  include JSON::Serializable

  getter results : Array(MultiSearchResult)
end
