class FetchOptions {
  final Map<String, String>? headers;
  final bool? noResolveJson;

  const FetchOptions({this.headers, this.noResolveJson});
}

class Bucket {
  final String id;
  final String name;
  final String owner;
  final String createdAt;
  final String updatedAt;
  final bool public;

  const Bucket({
    required this.id,
    required this.name,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.public,
  });

  Bucket.fromJson(Map<String, dynamic> json)
      : id = (json)['id'] as String,
        name = json['name'] as String,
        owner = json['owner'] as String,
        createdAt = json['created_at'] as String,
        updatedAt = json['updated_at'] as String,
        public = json['public'] as bool;
}

class FileObject {
  final String name;
  final String? bucketId;
  final String? owner;
  final String? id;
  final String? updatedAt;
  final String? createdAt;
  final String? lastAccessedAt;
  final Metadata? metadata;
  final Bucket? buckets;

  const FileObject({
    required this.name,
    required this.bucketId,
    required this.owner,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.lastAccessedAt,
    required this.metadata,
    required this.buckets,
  });

  FileObject.fromJson(dynamic json)
      : id = (json as Map<String, dynamic>)['id'] as String?,
        name = json['name'] as String,
        bucketId = json['bucket_id'] as String?,
        owner = json['owner'] as String?,
        updatedAt = json['updated_at'] as String?,
        createdAt = json['created_at'] as String?,
        lastAccessedAt = json['last_accessed_at'] as String?,
        metadata = json['metadata'] != null
            ? Metadata.fromJson(json['metadata'])
            : null,
        buckets =
            json['buckets'] != null ? Bucket.fromJson(json['buckets']) : null;
}

class BucketOptions {
  final bool public;

  const BucketOptions({required this.public});
}

class FileOptions {
  final String cacheControl;
  final bool upsert;

  /// Used as Content-Type
  /// Gets parsed with [MediaType.parse(mime)]
  ///
  /// Throws a FormatError if the media type is invalid.
  final String? contentType;

  const FileOptions({
    this.cacheControl = '3600',
    this.upsert = false,
    this.contentType = 'text/plain;charset=UTF-8',
  });
}

class SearchOptions {
  /// The number of files you want to be returned. */
  final int? limit;

  /// The starting position. */
  final int? offset;

  /// The column to sort by. Can be any column inside a FileObject. */
  final SortBy? sortBy;

  /// The search string to filter files by.
  final String? search;

  const SearchOptions({
    this.limit = 100,
    this.offset = 0,
    this.sortBy = const SortBy(
      column: 'name',
      order: 'asc',
    ),
    this.search,
  });

  Map<String, dynamic> toMap() {
    return {
      'limit': limit,
      'offset': offset,
      'sortBy': sortBy?.toMap(),
      'search': search,
    };
  }
}

class SortBy {
  final String? column;
  final String? order;

  const SortBy({this.column, this.order});

  Map<String, dynamic> toMap() {
    return {
      'column': column,
      'order': order,
    };
  }
}

// TODO: need to check for metadata props. The api swagger doesnt have.
class Metadata {
  const Metadata({required this.name});

  Metadata.fromJson(Map<String, dynamic> json)
      : name = (json)['name'] as String;

  final String name;
}

class SignedUrl {
  final String? path;
  final String? signedUrl;

  const SignedUrl({this.path, this.signedUrl});

  @override
  String toString() => 'SignedUrl(path: $path, signedUrl: $signedUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignedUrl &&
        other.path == path &&
        other.signedUrl == signedUrl;
  }

  @override
  int get hashCode => path.hashCode ^ signedUrl.hashCode;

  SignedUrl copyWith({
    String? path,
    String? signedUrl,
  }) {
    return SignedUrl(
      path: path ?? this.path,
      signedUrl: signedUrl ?? this.signedUrl,
    );
  }
}

class StorageException {
  final String message;
  final String? error;
  final String? statusCode;

  const StorageException(this.message, {this.error, this.statusCode});

  StorageException.fromJson(Map<String, dynamic> json, [String? statusCode])
      : message = json['message'] as String,
        error = json['error'] as String?,
        statusCode = (json['statusCode'] as String?) ?? statusCode;

  @override
  String toString() {
    return 'StorageError(message: $message, statusCode: $statusCode, error: $error)';
  }
}
