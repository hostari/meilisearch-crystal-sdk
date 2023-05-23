class Meilisearch::Document
  def self.add_or_update(
    index_uid : String,
    document_body : Array(Hash(String, Int32 | String))
  ) : TaskStatus
    response = Meilisearch.client.put("/indexes/#{index_uid}/documents", body: {"index_uid": index_uid, "document_body": document_body}.to_json)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
