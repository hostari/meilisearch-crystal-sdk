class Meilisearch::Task
  def self.cancel_task(
    query_parameter : String
  )
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(query_parameter) %}
        builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
      {% end %}

    response = Meilisearch.client.post("/tasks/cancel?#{query_parameter}", form: io.to_s)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
