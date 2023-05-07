class Meilisearch::Index
  def self.swap_indexes(
    index_pair : Array(NamedTuple(indexes: Array(String)))
  ) : TaskStatus
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(index_pair) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Meilisearch.client.post("/swap-indexes", form: io.to_s)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
