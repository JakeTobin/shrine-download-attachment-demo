
NOTE: Only the album thumbnail is using the download attachment passthrough. Create an album with name and image then view the root of the application again to see that the image is passing through /attachments

https://github.com/shrinerb/shrine/blob/v2.16.0/doc/plugins/download_endpoint.md#readme

* Install the gems:

  ```rb
  $ bundle install
  ```

* Have SQLite installed and run the migrations:

  ```sh
  $ rake db:migrate
  ```

* Put your Amazon S3 credentials in `.env` and [setup CORS].

  ```sh
  # .env
  S3_BUCKET="..."
  S3_REGION="..."
  S3_ACCESS_KEY_ID="..."
  S3_SECRET_ACCESS_KEY="..."
  ```

Once you have all of these things set up, you can run the app:

```sh
$ rails server
```

[Shrine]: https://github.com/shrinerb/shrine
[setup CORS]: http://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html
[Uppy]: https://uppy.io
