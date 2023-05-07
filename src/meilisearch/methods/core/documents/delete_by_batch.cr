class Meilisearch::Document
  def self.delete_by_batch(
    index_uid : String,
    document_id : Array(Int32)
  ) : Bool forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(index_uid document_id) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Meilisearch.client.delete("/indexes/#{index_uid}/documents/delete-batch")
    if response.status_code == 202
      true
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
