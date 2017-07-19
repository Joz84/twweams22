class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  
  def first_url
     url_regex = /https?:\/\/[\da-z\.-]+\.[a-z\.]{2,6}[\/\w\.?=&-]*\/?/
     content.match(url_regex).to_s if content.match(url_regex)
  end
end
