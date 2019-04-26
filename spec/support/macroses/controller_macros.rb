module ControllerMacros
  def login_user
    before(:each) do
      sign_in create(:user)
    end
  end
end
