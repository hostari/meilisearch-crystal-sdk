require "../ext/enum/string_converter.cr"

class Meilisearch::Error < Exception
  include JSON::Serializable

  enum Type
    ApiKeyAlreadyExists
    ApiKeyNotFound
    BadRequest
    DatabaseSizeLimitReached
    DocumentFieldsLimitReached
    DocumentNotFound
    DumpProcessFailed
    ImmutableApiKeyActions
    ImmutableApiKeyCreatedAt
    ImmutableApiKeyExpiresAt
    ImmutableApiKeyIndexes
    ImmutableApiKey
    ImmutableApiKeyUid
    ImmutableApiKeyUpdatedAt
    ImmutableIndexUid
    ImmutableIndexUpdatedAt
    IndexAlreadyExists
    IndexCreationFailed
    IndexNotFound
    IndexPrimaryKeyAlreadyExists
    IndexPrimaryKeyMultipleCandidatesFound
    Internal
    InvalidApiKey
    InvalidApiKeyActions
    InvalidApiKeyDescription
    InvalidApiKeyExpiresAt
    InvalidApiKeyIndexes
    InvalidApiKeyLimit
    InvalidApiKeyName
    InvalidApiKeyOffset
    InvalidApiKeyUid
    InvalidContentType
    InvalidDocumentCsvDelimiter
    InvalidDocumentId
    InvalidDocumentFields
    InvalidDocumentLimit
    InvalidDocumentOffset
    InvalidDocumentGeoField
    InvalidIndexLimit
    InvalidIndexOffset
    InvalidIndexUid
    InvalidIndexPrimaryKey
    InvalidSearchAttributesToCrop
    InvalidSearchAttributesToHighlight
    InvalidSearchAttributesToRetrieve
    InvalidSearchCropLength
    InvalidSearchCropMarker
    InvalidSearchFacets
    InvalidSearchFilter
    InvalidSearchHighlightPostTag
    InvalidSearchHighlightPreTag
    InvalidSearchHitsPerPage
    InvalidSearchLimit
    InvalidSearchMatchingStrategy
    InvalidSearchOffset
    InvalidSearchPage
    InvalidSearchQ
    InvalidSearchShowMatchesPosition
    InvalidSearchSort
    InvalidSettingsDisplayedAttributes
    InvalidSettingsDistinctAttribute
    InvalidSettingsFaceting
    InvalidSettingsFilterableAttributes
    InvalidSettingsPagination
    InvalidSettingsRankingRules
    InvalidSettingsSearchableAttributes
    InvalidSettingsSortableAttributes
    InvalidSettingsStopWords
    InvalidSettingsSynonyms
    InvalidSettingsTypoTolerance
    InvalidState
    InvalidStoreFile
    InvalidSwapDuplicateIndexFound
    InvalidSwapIndexes
    InvalidTaskAfterEnqueuedAt
    InvalidTaskAfterFinishedAt
    InvalidTaskAfterStartedAt
    InvalidTaskBeforeEnqueuedAt
    InvalidTaskBeforeFinishedAt
    InvalidTaskBeforeStartedAt
    InvalidTaskCanceledBy
    InvalidTaskIndexUids
    InvalidTaskLimit
    InvalidTaskStatuses
    InvalidTaskTypes
    InvalidTaskUids
    IoError
    IndexPrimaryKeyNoCandidateFound
    MalformedPayload
    MissingApiKeyActions
    MissingApiKeyExpiresAt
    MissingApiKeyIndexes
    MissingAuthorizationHeader
    MissingContentType
    MissingDocumentId
    MissingIndexUid
    MissingMasterKey
    MissingPayload
    MissingSwapIndexes
    MissingTaskFilters
    NoSpaceLeftOnDevice
    NotFound
    PayloadTooLarge
    TaskNotFound
    TooManyOpenFiles
    UnretrievableDocument
  end

  @[JSON::Field(converter: Enum::StringConverter(Meilisearch::Error::Type))]
  property type : Meilisearch::Error::Type
  property message : String?
  property type : String
  property link : String
end
