module MeilisearchMethods
  extend self

  macro add_list_with_index_uid_method(*arguments)
  {% begin %}
    def self.list_with_index_uid(index_uid : String, {{*arguments}}) : List({{@type.id}})
      io = IO::Memory.new
      builder = ParamsBuilder.new(io)
  
  
      {% for x in arguments.map &.var.id %}
        builder.add({{x.stringify}}, {{x.id}}) unless {{x.id}}.nil?
      {% end %}
  
        response = Meilisearch.client.get("/indexes/#{index_uid}/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}s", form: io.to_s)
  
      if response.status_code == 200
        List({{@type.id}}).from_json(response.body)
      else
        raise Error.from_json(response.body, "error")
      end
    end
  {% end %}
  end
end
