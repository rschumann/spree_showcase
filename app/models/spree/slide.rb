module Spree
  class Slide < ActiveRecord::Base

      
    has_attached_file   :image,
                      :styles =>{
                        :max400  => "400x",
                        :max800 => "800x",
                        :max1000 => "1000x",
                        :max1300 => "1300x",
                        :large => "1600x"
                      },
                      :storage => :s3,
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :s3_host_name => 's3-eu-west-1.amazonaws.com',
                      :url => '/spree/showcase/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/showcase/:id/:style/:basename.:extension'
    


    attachment_definitions[:image] = (attachment_definitions[:image] || {}).merge(s3_options)
    
    default_scope order(:position) # Slides should always be ordered by position specified by user.
    scope :published, where(:published=>true)
    scope :no_slides, lambda {|num| limit(num)}
    attr_accessible :name, :body, :target_url, :published, :image, :thumbnail_message
  end
end
