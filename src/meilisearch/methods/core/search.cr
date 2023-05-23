class Meilisearch::Search
  def self.post_search(
    index_uid : String,
    q : String?, # When q isn't specified, Meilisearch performs a placeholder search. Placeholder search is particularly useful when building a faceted search interfaces, as it allows users to view the catalog and alter sorting rules without entering a query
    offset : Int32? = 0,
    limit : Int32? = 20,
    hits_per_page : Int32? = 1,
    page : Int32? = 1,
    filter : Array(String)? = nil,
    facets : Array(String)? = nil,
    attributes_to_retrieve : Array(String)? = ["*"],
    attributes_to_crop : Array(String)? = nil,
    crop_length : Int32? = 10,
    crop_marker : String? = "…",
    attributes_to_highlight : Array(String)? = nil,
    highlight_pre_tag : String? = "<em>",
    highlight_post_tag : String? = "</em>",
    show_matches_position : Bool? = false,
    sort : Array(String)? = nil,
    matching_strategy : String = "last"
  )
    body = {"index_uid":               index_uid,
            "q":                       q,
            "offset":                  offset,
            "limit":                   limit,
            "hits_per_page":           hits_per_page,
            "page":                    page,
            "filter":                  filter,
            "facets":                  facets,
            "attributes_to_retrieve":  attributes_to_retrieve,
            "attributes_to_crop":      attributes_to_crop,
            "crop_length":             crop_length,
            "attributes_to_highlight": attributes_to_highlight,
            "highlight_pre_tag":       highlight_pre_tag,
            "highlight_post_tag":      highlight_post_tag,
            "show_matches_position":   show_matches_position,
            "sort":                    sort,
            "matching_strategy":       matching_strategy,
    }

    response = Meilisearch.client.post("/indexes/#{index_uid}/search", body: body.to_json)

    if response.status_code == 200
      SearchResults(JSON::Any).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
