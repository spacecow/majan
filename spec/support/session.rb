def login_admin
  login(create_admin)
end

private

  def login(user = create_member)
    visit login_path
    fill_in 'Login', with:user.userid
    fill_in 'Password', with:user.password
    click_button 'Login'
  end
