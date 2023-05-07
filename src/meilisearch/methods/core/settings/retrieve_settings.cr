module MeilisearchMethods
  extend self

  macro add_retrieve_settings_method(*arguments)
    {% begin %}
      def self.retrieve_settings(index_uid : String, {{*arguments}}) : Meilisearch::Settings
        io = IO::Memory.new
        builder = ParamsBuilder.new(io)
    
        {% for x in arguments.map &.var.id %}
          builder.add({{x.stringify}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}
    
        response = Meilisearch.client.get("/indexes/#{index_uid}/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}", form: io.to_s)
    
        if response.status_code == 200
          Meilisearch::Settings.from_json(response.body)
        else
          raise Error.from_json(response.body, "error")
        end
      end
    {% end %}
    end
end
