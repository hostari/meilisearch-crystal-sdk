class Meilisearch::Stats
  include JSON::Serializable
  include MeilisearchMethods

  add_retrieve_stat_method
  add_list_stats_method(
    uid : String? = nil,
  )

  getter numberOfDocuments : Int32
  getter isIndexing : Bool
  getter fieldDistribution : Hash(String, Int32)
end
