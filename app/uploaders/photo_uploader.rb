class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

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

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
