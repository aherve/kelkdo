module Facebookable
  extend ActiveSupport::Concern

  included do 
    field :first_name, type: String
    field :last_name, type: String
    field :email, type: String
    field :gender, type: String
    field :provider, type: String
    field :uid, type: String
    index({uid: 1},{unique: true, name: 'UsrfacebookUid'} )
  end

  class FbConnector
    class << self
      def conn
        Faraday.new(:url => 'https://graph.facebook.com/user') do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
          faraday.params["access_token"] = [FACEBOOK_APP_TOKEN,FACEBOOK_APP_SECRET].join("|")
        end
      end
    end
  end

  def fb_friends_hash
    f = Rails.cache.fetch("usrFbFriends|#{id}", expires_in: 5.minutes) do 
      provider == "facebook" ? JSON.parse(FbConnector.conn.get("/#{uid}/friends").body)["data"] : []
    end
    f || []
  end

  def fb_friend_uids
    f = (provider == "facebook" ? fb_friends_hash.map{|h| h["id"]} : [])
    f || []
  end

  def fb_app_friends
    f = (provider == "facebook" ? User.find(uid: fb_friend_uids) : [] )
    f || []
  end

  def image
    "http://graph.facebook.com/#{uid}/picture"
  end

  module ClassMethods
    def from_omniauth(auth)

        where(auth.slice(:provider, :uid)).first_or_create do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.first_name = auth.info.first_name   # assuming the user model has a name
          user.last_name  = auth.info.last_name   # assuming the user model has a name
          user.gender = auth.info.gender
          user
        end

    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
