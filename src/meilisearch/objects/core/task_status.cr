class Meilisearch::TaskStatus
  include JSON::Serializable

  getter taskUid : Int32?
  getter indexUid : String?
  getter status : String?
  getter enqueuedAt : String | Time?

  @[JSON::Field(converter: Enum::StringConverter(Meilisearch::Task::Type))]
  property type : Meilisearch::Task::Type
end
