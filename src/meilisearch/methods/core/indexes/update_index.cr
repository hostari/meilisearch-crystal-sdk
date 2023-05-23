class Meilisearch::Index
  def self.update(
    index : String | Index,
    primaryKey : String
  ) : TaskStatus
    case index
    when String then index_uid = index
    when Index  then index_uid = index.uid
    end

    response = Meilisearch.client.patch("/indexes/#{index_uid}", body: {"index": index, "primaryKey": primaryKey}.to_json)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
