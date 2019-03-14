require "shrine"

  require "shrine/storage/s3"

  s3_options = {
    access_key_id:     Rails.application.secrets.s3_access_key_id,
    secret_access_key: Rails.application.secrets.s3_secret_access_key,
    region:            Rails.application.secrets.s3_region,
    bucket:            Rails.application.secrets.s3_bucket,
  }

  # s3.url(download: true)

  s3_cache = Shrine::Storage::S3.new(prefix: "cache", **s3_options)
  s3_store = Shrine::Storage::S3.new(**s3_options)

  Shrine.storages = {
    cache: s3_cache,
    store: s3_store,
  }


Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :logging
Shrine.plugin :determine_mime_type
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :download_endpoint, prefix: "attachments"


Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  # Uppy will send the "filename" and "type" query parameters
  filename = request.params["filename"]
  type     = request.params["type"]

  {
    content_disposition:    "inline; filename=\"#{filename}\"", # set download filename
    content_type:           type,                               # set content type (defaults to "application/octet-stream")
    content_length_range:   0..(10*1024*1024),                  # limit upload size to 10 MB
  }
}


Shrine::Attacher.promote { |data| PromoteJob.perform_async(data) }
Shrine::Attacher.delete { |data| DeleteJob.perform_async(data) }
