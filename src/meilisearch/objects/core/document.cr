@[EventPayload]

class Meilisearch::Document
  include JSON::Serializable
  include MeilisearchMethods

  add_retrieve_with_index_uid_method

  add_list_with_index_uid_method(
    uid : String? = nil,
  )
  getter id : Int32? = nil
end
