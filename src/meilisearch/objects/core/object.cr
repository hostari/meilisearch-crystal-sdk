class Meilisearch::Object(T)
  include JSON::Serializable

  getter data : T
end
