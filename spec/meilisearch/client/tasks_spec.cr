require "../../spec_helper"

describe Meilisearch::Task do
  it "lists all tasks regardless of index" do
    WebMock.stub(:get, "http://localhost:7700/tasks")
      .to_return(status: 200, body: File.read("spec/support/tasks.json"), headers: {"Content-Type" => "application/json"})

    response = Meilisearch::Task.list
    response.total.should eq(2)
  end

  it "lists one task given a uid" do
    WebMock.stub(:get, "http://localhost:7700/tasks/1")
      .to_return(status: 200, body: File.read("spec/support/task_1.json"), headers: {"Content-Type" => "application/json"})

    task = Meilisearch::Task.retrieve("1")
    task.uid.should eq(1)
  end

  it "cancels any number of enqueued or processing tasks based on their uid, status, type, indexUid, or the date at which they were enqueued, processed, or completed." do
    WebMock.stub(:post, "http://localhost:7700/tasks/cancel?uids=3&status=enqueued")
      .to_return(status: 200, body: File.read("spec/support/canceled_task.json"), headers: {"Content-Type" => "application/json"})

    task = Meilisearch::Task.cancel_task("uids=3&status=enqueued")

    task.status.should eq("enqueued")
  end

  it "deletes a finished (succeeded, failed, or canceled) task based on uid, status, type, indexUid, canceledBy, or date." do
    WebMock.stub(:delete, "http://localhost:7700/tasks?uids=3&status=enqueued")
      .to_return(status: 204, headers: {"Content-Type" => "application/json"})

    task = Meilisearch::Task.delete_task("uids=3&status=enqueued")
    task.should eq(true)
  end
end
