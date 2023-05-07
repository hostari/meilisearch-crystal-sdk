module MeilisearchMethods
  extend self

  macro add_list_stats_method(*arguments)
  {% begin %}
    def self.list_stats({{*arguments}}) 
      io = IO::Memory.new
      builder = ParamsBuilder.new(io)
  
  
      {% for x in arguments.map &.var.id %}
        builder.add({{x.stringify}}, {{x.id}}) unless {{x.id}}.nil?
      {% end %}
  
        response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}", form: io.to_s)
  
      if response.status_code == 200
          StatsList.from_json(response.body)
      else
        raise Error.from_json(response.body, "error")
      end
    end
  {% end %}
  end
end
