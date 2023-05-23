class Meilisearch::MultiSearch
  def self.search(
    queries : Array(Hash(String, String | Int32 | Bool | Array(String)))
  )
    response = Meilisearch.client.post("/multi-search", body: {"queries": queries}.to_json)

    if response.status_code == 200
      MultiSearchResults.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
