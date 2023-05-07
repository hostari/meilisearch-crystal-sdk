module MeilisearchMethods
  extend self

  macro add_list_method(*arguments)
{% begin %}
  def self.list({{*arguments}}) : List({{@type.id}})
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)


    {% for x in arguments.map &.var.id %}
      builder.add({{x.stringify}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    if {{@type.id}} == Meilisearch::Index
      response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}es", form: io.to_s)
    else
      response = Meilisearch.client.get("/#{"{{@type.id.gsub(/Meilisearch::/, "").underscore.gsub(/::/, "/")}}"}s", form: io.to_s)
    end

    if response.status_code == 200
        List({{@type.id}}).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
{% end %}
end
end
