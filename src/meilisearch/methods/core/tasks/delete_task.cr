class Meilisearch::Task
  def self.delete_task(
    query_parameter : String
  )
    response = Meilisearch.client.delete("/tasks?#{query_parameter}")

    if response.status_code == 204
      true
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
