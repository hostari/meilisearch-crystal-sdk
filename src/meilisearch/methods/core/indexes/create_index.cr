class Meilisearch::Index
  def self.create(
    uid : String,
    primaryKey : String
  ) #: TaskStatus
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(uid primaryKey) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Meilisearch.client.post("/indexes", form: io.to_s)

    if response.status_code == 200
      pp response.body
      #TaskStatus.from_json(response.body)
    else
      pp response.body
      #raise Error.from_json(response.body, "error")
    end
  end
end
