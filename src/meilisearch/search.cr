module MeiliSearch
  class Search
    def initialize(@master_key : String, @base_url : String)
      @client = MeiliSearch::Client.new(@master_key, @base_url)
    end

    # requires API key and allows preflight request caching and better performances
    def search(index_uid : String, keyword : String)
      @client.post("/indexes/#{index_uid}/search", body: {"q" => keyword}.to_json)
    end

    # also known as federated search
    # allows multiple search queries on one or more indexes by bundling them into a single HTTP request
    def multi_search(queries : Array(Hash(String, String | Int32)))
      @client.post("/multi-search", body: {"queries" => queries}.to_json)
    end
  end
end
