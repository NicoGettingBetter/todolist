FactoryGirl.define do 
  factory :file_attachment do
    url { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/comment.rb") }
  end
end