class Meilisearch::Index
  def self.update(
    index : String | Index,
    primaryKey : String
  ) : TaskStatus
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(primaryKey) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.is_a?(Unset)
    {% end %}

    case index
    when String then index_uid = index
    when Index  then index_uid = index.uid
    end

    response = Meilisearch.client.patch("/indexes/#{index_uid}", form: io.to_s)

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
