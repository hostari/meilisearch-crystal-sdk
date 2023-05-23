class Meilisearch::Index
  def self.swap_indexes(
    index_pair : Array(NamedTuple(indexes: Array(String)))
  ) : TaskStatus
    response = Meilisearch.client.post("/swap-indexes", body: {"index_pair": index_pair}.to_json)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
