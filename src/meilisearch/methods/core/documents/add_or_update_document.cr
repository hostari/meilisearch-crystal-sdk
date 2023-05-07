class Meilisearch::Document
  def self.add_or_update(
    index_uid : String,
    body : Array(Hash(String, Int32 | String))
  ) : TaskStatus
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(index_uid body) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Meilisearch.client.put("/indexes/#{index_uid}/documents", form: io.to_s)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
