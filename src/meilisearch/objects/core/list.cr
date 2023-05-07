class Meilisearch::List(T)
  include JSON::Serializable
  include Enumerable(T)

  getter results : Array(T)
  getter offset : Int32?
  getter limit : Int32?
  getter total : Int32?

  def each(&block)
    results.each do |i|
      yield i
    end
  end
end
