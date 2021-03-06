class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  
  def auto
    manipulate! do|image|
      image.auto_orient
    end
  end
 
  process :auto

  process :resize_to_limit => [700, 700]
  
  #画像リサイズ処理
  def create_thumb(width, height)
    manipulate! do |img|
      narrow = img.columns > img.rows ? img.rows : img.columns
      img.crop(Magick::CenterGravity, narrow, narrow).resize(width, height)
    end
  end

  version :thumb1 do
    process :create_thumb => [240, 260]
  end

  version :thumb2 do
    process :create_thumb => [120, 135]
  end

  version :thumb3 do
    process :create_thumb => [40, 40]
  end

  

  process :convert => 'jpg'

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png )
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
end
