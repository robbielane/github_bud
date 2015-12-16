class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.nickname           = auth_info.extra.raw_info.login
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end

  def details
    OpenStruct.new(GithubService.new(self).user_data)
  end

  def orgs
    GithubService.new(self).user_orgs.map { |org| OpenStruct.new(org) }
  end

  def github_join_date
    DateTime.parse(details.created_at).strftime('%b %d, %Y')
  end
end
