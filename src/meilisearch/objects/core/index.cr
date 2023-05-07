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

  getter taskUid : Int32?
  getter indexUid : String?
  getter status : String?
  getter type : Meilisearch::Task::Type?
  getter enqueuedAt : Time?
end
