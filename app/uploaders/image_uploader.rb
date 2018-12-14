class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Piet::CarrierWaveExtension

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_limit => [800, 800]
  process convert: 'jpg'
  process optimize: [quality: 70]

  # Create different versions of your uploaded files:
  version :main_image do
    process resize_to_fit: [400, 300]
  end

  version :thumbnail do
    process resize_to_fit: [200, 150]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def size_range
    0..20.megabytes
  end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
end
