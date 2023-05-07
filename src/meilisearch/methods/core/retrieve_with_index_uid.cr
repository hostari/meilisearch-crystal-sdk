module MeilisearchMethods
  extend self

  macro add_retrieve_with_index_uid_method(*arguments)
    {% begin %}
      def self.retrieve_with_index_uid(uid : String, id : Int32)
        response = Meilisearch.client.get("/indexes/#{uid}/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}s/#{id}")
  
        if response.status_code == 200
          {{@type.id}}.from_json(response.body)
        else
          raise Error.from_json(response.body, "error")
        end
      end
  
      def self.retrieve_with_index_uid({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
        retrieve({{@type.id.gsub(/Meilisearch::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
      end
    {% end %}
    end
end
