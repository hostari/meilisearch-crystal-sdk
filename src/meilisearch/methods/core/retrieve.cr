module MeilisearchMethods
  extend self

  macro add_retrieve_method(*arguments)
  {% begin %}
    def self.retrieve(uid : String)
      if {{@type.id}} == Meilisearch::Index
        response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}es/#{uid}")
      elsif {{@type.id}} == Meilisearch::Stats
        response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}/#{uid}")
      else
        response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}s/#{uid}")
      end

      if response.status_code == 200
        {{@type.id}}.from_json(response.body)
      else
        raise Error.from_json(response.body, "error")
      end
    end

    def self.retrieve({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
      retrieve({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
    end
  {% end %}
  end
end
