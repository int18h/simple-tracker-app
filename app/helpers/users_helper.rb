module UsersHelper

  def gravatar_for(user, small = '')
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar #{small} img-circle")
  end

  def profile_link_to_user(user)
    return "#{link_to user.full_name, user_path(user)}".html_safe
  end
end
