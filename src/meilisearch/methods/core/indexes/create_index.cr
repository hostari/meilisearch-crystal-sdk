class Meilisearch::Index
  def self.create(
    uid : String,
    primaryKey : String
  ) : TaskStatus
    response = Meilisearch.client.post("/indexes", body: {"uid": uid, "primaryKey": primaryKey}.to_json)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
