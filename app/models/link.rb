# == Schema Information
#
# Table name: links
#
#  id            :integer          not null, primary key
#  url           :string(255)
#  http_response :integer
#  site_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Link < ActiveRecord::Base
  belongs_to :site
end
