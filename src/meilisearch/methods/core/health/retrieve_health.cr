module MeilisearchMethods
  extend self

  macro add_retrieve_health_method(*arguments)
    {% begin %}
      def self.retrieve_health
        response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}")
  
        if response.status_code == 200
          Health.from_json(response.body)
        else
          raise Error.from_json(response.body, "error")
        end
      end
  
      def self.retrieve_health({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
        retrieve_health({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
      end
    {% end %}
    end
end
