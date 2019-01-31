class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :w170 do
    process resize_to_fit: [170, nil]
  end

  version :w210 do
    process resize_to_fit: [210, nil]
  end

  version :w550 do
    process resize_to_fit: [550, nil]
  end

  def default_url(*args)
    return ActionController::Base.helpers.asset_path([version_name].compact.join('_')) if version_name
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
