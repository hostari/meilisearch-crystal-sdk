@[EventPayload]

class Meilisearch::Health
  include JSON::Serializable
  include MeilisearchMethods

  add_retrieve_health_method

  getter status : String
end
