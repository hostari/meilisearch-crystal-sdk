module MeilisearchMethods
  extend self

  macro add_delete_method
  {% begin %}
    def self.delete(uid : String)
        if {{@type.id}} == Meilisearch::Index
            response = Meilisearch.client.delete("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}es/#{uid}")
        else
            response = Meilisearch.client.delete("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}s/#{uid}")
        end
  
      if response.status_code == 202
        true
      else
        raise Error.from_json(response.body, "error")
      end
    end
  
    def self.delete({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
      delete({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
    end
  {% end %}
  end
end
