require "rails_helper"

feature "Sign in with social account" do
  context "when oauth confirmed" do
    include_context :stub_omniauth

    context "when user found by uid" do
      let!(:identity) { create(:identity, user: user) }
      let(:user) { create(:user, :from_auth_hashie) }

      it_behaves_like "success sign in"
    end

    context "when user found by email" do
      let!(:user) { create(:user, :from_auth_hashie) }

      it_behaves_like "success sign in"
    end

    context "when user not found" do
      let(:user) { User.last }

      before do
        visit new_user_session_path
        click_link "Sign in with Facebook"
      end

      it "forces user to update password" do
        expect(page).to have_content("Set your password, please")
        visit root_path
        expect(page).to have_content("Set your password, please")
      end

      context "when user updates password" do
        it "redirect user to home page" do
          fill_form(:user, enter_new_password: "123456", confirm_your_new_password: "123456")
          click_on "Update password"
          expect(page).to have_content(I18n.t("passwords.updated"))
          expect(page).to have_content("Home")
        end
      end
    end
  end

  context "when oauth not confirmed" do
    include_context :stub_not_verified_omniauth

    scenario "Visitor sees alert message" do
      visit new_user_session_path
      click_link "Sign in with Facebook"

      expect(page).to have_text("Please confirm your Facebook account before continuing.")
    end
  end
end
