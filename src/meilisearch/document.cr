module MeiliSearch
  class Document
    def initialize(@master_key : String, @base_url : String)
      @client = MeiliSearch::Client.new(@master_key, @base_url)
    end

    def list_all(index_uid : String)
      @client.get("/indexes/#{index_uid}/documents")
    end

    def list_one(index_uid : String, document_id : String)
      @client.get("/indexes/#{index_uid}/documents/#{document_id}")
    end

    # overwrites document if it exists, otherwise, creates it
    def add_or_replace(index_uid : String, body : Array(Hash(String, Int32 | String)))
      @client.post("/indexes/#{index_uid}/documents", body: body.to_json)
    end

    def add_or_update(index_uid : String, body : Array(Hash(String, Int32 | String)))
      @client.put("/indexes/#{index_uid}/documents", body: body.to_json)
    end

    def delete_all(index_uid : String)
      @client.delete("/indexes/#{index_uid}/documents")
    end

    def delete(index_uid : String, document_id : String)
      @client.delete("/indexes/#{index_uid}/documents/#{document_id}")
    end

    def delete_by_batch(index_uid : String, body : Array(Int32))
      @client.delete("/indexes/#{index_uid}/documents/delete-batch", body: body.to_json)
    end
  end
end
