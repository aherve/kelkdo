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
          faraday.params["access_token"] = [ENV['FACEBOOK_APP_TOKEN'],ENV['FACEBOOK_APP_SECRET']].join("|")
        end
      end
    end
  end

  def friend_uids
    f = (provider == "facebook" ? fb_friends_hash.map{|h| h["id"]} : [])
    f || []
  end

  def friend_ids
    f = (provider == "facebook" ? User.any_in(uid: friend_uids).only(:id).map(&:id) : [] )
    f || []
  end

  def friends
    f = (provider == "facebook" ? User.any_in(uid: friend_uids) : [] )
    f || []
  end

  def friends_count
    friend_uids.size
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
          user.password = Devise.friendly_token[0,20]
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

  private

  def fb_friends_hash
    time = if Rails.env.production?
             5.minutes
           else
             5.seconds
           end
    f = Rails.cache.fetch("UsrFbFriends|#{id}", expires_in: time) do 
      provider == "facebook" ? JSON.parse(FbConnector.conn.get("/#{uid}/friends").body)["data"] : []
    end
    f || []
  end

end
