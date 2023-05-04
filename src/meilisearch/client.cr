module MeiliSearch
  class Client
    # base url for development: http://localhost:7700
    def initialize(@master_key : String, @base_url : String, @environment : String = "development")
    end

    def reset_client
      if @environment == "development"
        client = HTTP::Client.new(URI.parse(@base_url))
      else
        client = HTTP::Client.new(URI.parse(@base_url), tls: true)
      end

      client.before_request do |request|
        request.headers["Authorization"] = "Bearer #{@master_key}"
        request.headers["Content-Type"] = "application/json"
      end

      client
    end

    def get(path : String)
      reset_client.get("#{@base_url}#{path}")
    end

    def post(path : String, body : String = "")
      reset_client.post("#{@base_url}#{path}", body: body)
    end

    def patch(path : String, body : String = "")
      reset_client.patch("#{@base_url}#{path}", body: body)
    end

    def delete(path : String, body : String = "")
      reset_client.delete("#{@base_url}#{path}", body: body)
    end
  end
end
