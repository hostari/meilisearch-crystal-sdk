class Meilisearch::Index
  def self.create(
    uid : String,
    primary_key : String
  ) : TaskStatus
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(uid primary_key) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Meilisearch.client.post("/indexes", form: io.to_s)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
