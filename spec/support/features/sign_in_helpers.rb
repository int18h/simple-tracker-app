module SignInHelpers
  def sign_in
    sign_in_as 'person1@example.com', 'password1'
  end

  def sign_in_as(email, password, form_selector="#sign-in-form", js = false)
    create :user, email: email, password: password
    visit signin_path
    within(form_selector) do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign In'
    end
  end
end

RSpec.configure do |config|
  config.include SignInHelpers
end
