class Meilisearch::Settings
  include JSON::Serializable
  include MeilisearchMethods

  add_retrieve_settings_method

  getter rankingRules : Array(String)?
  getter filterableAttributes : Array(String)?
  getter distinctAttribute : String?
  getter searchableAttributes : Array(String)?
  getter displayedAttributes : Array(String)?
  getter sortableAttributes : Array(String)?
  getter stopWords : Array(String)?
  getter synonyms : Hash(String, Array(String))?
  getter typoTolerance : TypoTolerance?
  getter pagination : Hash(String, Int32)?
  getter faceting : Hash(String, Int32)?

  class TypoTolerance
    include JSON::Serializable

    getter enabled : Bool
    getter minWordSizeForTypos : Hash(String, Int32)
    getter disableOnWords : Array(String)
    getter disableOnAttributes : Array(String)
  end
end
