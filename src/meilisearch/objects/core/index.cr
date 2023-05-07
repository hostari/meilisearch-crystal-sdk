@[EventPayload]

class Meilisearch::Index
  include JSON::Serializable
  include MeilisearchMethods

  add_retrieve_method
  add_list_method(
    uid : String? = nil,
  )
  add_delete_method

  getter uid : String?
  getter primaryKey : String?
  getter createdAt : String?
  getter updatedAt : String?
end
