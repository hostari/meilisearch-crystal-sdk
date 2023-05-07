class Meilisearch::MultiSearch
  def self.search(
    queries : Array(Hash(String, String | Int32 | Bool | Array(String)))
  )
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(queries) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Meilisearch.client.post("/multi-search", form: io.to_s)

    if response.status_code == 200
      MultiSearchResults.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
