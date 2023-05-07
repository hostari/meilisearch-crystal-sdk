require "json"
require "http/client"
require "./ext/**"

class Meilisearch
  class Unset
  end

  @@master_key : String?
  @@base_url : String?

  # @@version : String?

  def self.master_key=(master_key)
    @@master_key = master_key
  end

  def self.master_key
    @@master_key
  end

  def self.base_url=(base_url)
    @@master_key = master_key
  end

  def self.base_url
    @@base_url
  end

  # def self.version=(version)
  #   @@version
  # end

  def self.client : HTTP::Client
    return @@client.not_nil! unless @@client.nil?

    self.reset_client

    @@client.not_nil!
  end

  def self.reset_client
    @@client = HTTP::Client.new(URI.parse(@@base_url.not_nil!))

    @@client.not_nil!.before_request do |request|
      request.headers["Authorization"] = "Bearer #{@@master_key}"
      request.headers["Content-Type"] = "application/json"
    end
  end
end

annotation EventPayload
end

require "./meilisearch/**"
