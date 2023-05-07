require "spec"
require "webmock"

Spec.before_each &->WebMock.reset
Spec.before_each { Meilisearch.master_key = "test" }
Spec.before_each { Meilisearch.base_url = "http://localhost:7700" }
require "../src/meilisearch-crystal-sdk"
