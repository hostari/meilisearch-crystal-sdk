@[EventPayload]

class Meilisearch::Task
  include JSON::Serializable
  include MeilisearchMethods

  add_retrieve_method
  add_list_method(
    uid : String? = nil,
  )

  getter uid : Int32
  getter indexUid : String
  getter status : String
  getter canceledBy : Int32? = nil
  getter details : Hash(String, Int32)? | String? | Int32? | Array(NamedTuple(indexes: Array(String)))? | Array(String)? | Hash(String, Array(String))
  getter error : Error? = nil
  getter duration : String? = nil
  getter enqueuedAt : Time
  getter startedAt : Time? = nil
  getter finishedAt : Time? = nil

  enum Type
    IndexCreation
    IndexUpdate
    IndexDeletion
    IndexSwap
    DocumentAdditionOrUpdate
    DocumentDeletion
    SettingsUpdate
    DumpCreation
    TaskCancelation
    TaskDeletion
    SnapshotCreation
  end

  @[JSON::Field(converter: Enum::StringConverter(Meilisearch::Task::Type))]
  property type : Type
end
