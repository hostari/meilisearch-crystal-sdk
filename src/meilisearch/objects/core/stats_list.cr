class Meilisearch::StatsList
  include JSON::Serializable

  getter indexes : Hash(String, Stats)
  getter databaseSize : Int32
  getter lastUpdate : Time
end
