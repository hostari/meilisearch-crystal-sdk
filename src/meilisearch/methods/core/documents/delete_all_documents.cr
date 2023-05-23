class Meilisearch::Document
  def self.delete_all(
    index_uid : String
  ) : Bool forall T, U
    response = Meilisearch.client.delete("/indexes/#{index_uid}/documents")
    if response.status_code == 202
      true
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
