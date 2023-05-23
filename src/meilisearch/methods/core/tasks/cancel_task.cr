class Meilisearch::Task
  def self.cancel_task(
    query_parameter : String
  )
    response = Meilisearch.client.post("/tasks/cancel?#{query_parameter}")

    if response.status_code == 200
      TaskStatus.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
