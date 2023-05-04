module MeiliSearch
  class Index
    def initialize(@master_key : String, @base_url : String, @environment : String = "development")
      @client = MeiliSearch::Client.new(@master_key, @base_url, @environment)
    end

    def list_all(offset : Int64? = nil, limit : Int64? = nil)
      if offset && limit
        response = @client.get("/indexes?offset=#{offset}&limit=#{limit}")
        # add spec
      elsif offset && limit.nil?
        @client.get("/indexes?offset=#{offset}")
        # add spec
      elsif offset.nil? && limit
        @client.get("/indexes?limit=#{limit}")
      else
        @client.get("/indexes")
      end
    end

    def get_index(index_uid : String)
      @client.get("/indexes/#{index_uid}")
    end

    def create_index(uid : String, primary_key : String)
      @client.post("/indexes", body: {uid: uid, primary_key: primary_key}.to_json)
    end

    def update_index(uid : String, primary_key : String)
      @client.patch("/indexes/#{uid}", body: {primary_key: primary_key}.to_json)
    end

    def delete_index(uid : String, primary_key : String)
      @client.delete("/indexes/#{uid}")
    end

    def swap_indexes(index_pair : Array(NamedTuple(indexes: Array(String))))
      @client.post("/swap-indexes", body: index_pair.to_json)
    end
  end
end
