@[EventPayload]

class Meilisearch::MultiSearchResult
  include JSON::Serializable

  getter indexUid : String
  getter hits : Array(JSON::Any)
  getter offset : Int32?
  getter limit : Int32?
  getter estimatedTotalHits : Int32?
  getter totalHits : Int32?
  getter totalPages : Int32?
  getter hitsPerPage : Int32?
  getter page : Int32?
  getter facetDistribution : Hash(String, Array(String))?
  getter facetStats : Hash(String, Hash(String, Float32))?
  getter processingTimeMs : Int32?
  getter query : String?
end
