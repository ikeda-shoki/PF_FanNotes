# frozen_string_literal: true

require 'rails_helper'

describe 'Userのテスト' do
  let!(:test_user){ FactoryBot.create(:test_user) }

  describe 'LogIn(new_users_session_path)のテスト' do
    before do
      visit '/users/sign_in'
    end
    context "リンクの表示" do
      it "LogInボタンがあるか" do
        expect(page).to have_button 'Log In'
      end
      it "SignUpリンクがあるか" do
        expect(page).to have_link 'Sign Up'
      end
    end
    context "ユーザー処理のテスト" do
      it "ユーザーがログインできるか" do
        fill_in "user_email", with: test_user.email
        fill_in "user_password", with: test_user.password
        click_on "Log In"
        expect(page).to have_content("ログインしました")
      end
    end
  end

  describe 'SignUp(new_user_registration_path)のテスト' do
    before do
      visit '/users/sign_up'
    end
    context "リンクの表示" do
      it "SignUpボタンがあるか" do
        expect(page).to have_button 'Sign Up'
      end
      it "Log Inリンクがあるか" do
        expect(page).to have_link 'Log In'
      end
    end
    context "ユーザー処理のテスト" do
      it "ユーザーが新規登録できるか" do
        fill_in "user_account_name", with: Faker::Name.unique.name
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "000000"
        fill_in "user_password_confirmation", with: "000000"
        click_on "Sign Up"
        expect(page).to have_content("アカウント登録が完了しました")
      end
    end
  end

  describe 'Userのテスト(ログイン済)' do
    let(:reception_user){ FactoryBot.create(:test_user) }
    let(:not_reception_user){ FactoryBot.create(:not_reception_user) }

    describe "ユーザー詳細画面(users/show)のテスト(is_reception: true)" do
      before do
        visit '/users/sign_in'
        fill_in "user_email", with: reception_user.email
        fill_in "user_password", with: reception_user.password
        click_on "Log In"
        visit '/users/' + reception_user.id.to_s
      end
      context "リンクのテスト" do
        it "ユーザー情報の編集リンクが存在する" do
          expect(page).to have_link "編集する"
        end
        it "ユーザー情報の編集リンク先が正しい" do
          click_link "編集する"
          expect(current_path).to eq("/users/" + reception_user.id.to_s + "/edit")
        end
        it "依頼中の内容のリンクが存在する" do
          expect(page).to have_link "依頼中の内容"
        end
        it "依頼中の内容のリンクが正しい" do
          click_link "依頼中の内容"
          expect(current_path).to eq("/users/" + reception_user.id.to_s + "/requesting")
        end
        it "依頼された内容のリンクが存在する" do
          expect(page).to have_link "依頼された内容"
        end
        it "依頼された内容のリンクが正しい" do
          click_link "依頼された内容"
          expect(current_path).to eq("/users/" + reception_user.id.to_s + "/requested")
        end
      end
      context "表示の確認" do
        it "現在のが依頼数表示されている" do
          expect(page).to have_content reception_user.request.count
        end
        it "現在の依頼数達成数が表示されている" do
          expect(page).to have_content reception_user.complete_request_count
        end
        it "現在の投稿数が表示されている" do
          expect(page).to have_content reception_user.post_images.count
        end
        it "現在の投稿数が表示されている" do
          expect(page).to have_content reception_user.following_user.count
        end
        it "現在の投稿数が表示されている" do
          expect(page).to have_content reception_user.followed_user.count
        end
        it "user.is_receptionがtrueの時、依頼受付中が表示されている" do
          expect(page).to have_content "依頼受付中"
        end
        it "reception_userの投稿のタイトルが表示されてる" do
          reception_user.post_images.each do |post_image|
            expect(page).to have_content post_image.title
          end
        end
        it "reception_userの投稿の画像が表示されてる" do
          reception_user.post_images.each do |post_image|
            expect(page).to have_selecter "img[src$= 'illust_1.jpg']"
          end
        end
        it "reception_userの投稿の画像をクリックすると画像詳細に遷移する" do
          reception_user.post_images.each do |post_image|
            post_image.click
            expect(current_path).to eq("/post_images/" + post_image.id.to_s)
          end
        end
      end
    end
    describe "ユーザー詳細画面(users/show)のテスト(is_reception: false)" do
      before do
        visit '/users/sign_in'
        fill_in "user_email", with: not_reception_user.email
        fill_in "user_password", with: not_reception_user.password
        click_on "Log In"
        visit '/users/' + not_reception_user.id.to_s
      end
      context "表示の確認" do
        it "user.is_receptionがfalseの時、依頼受付不可が表示されている" do
          expect(page).to have_content "依頼不可"
        end
        it "依頼された内容のリンクが存在しない" do
          expect(page).not_to have_link "依頼された内容"
        end
      end
    end
    describe "ユーザー詳細画面(users/show)のテスト(違うユーザーの場合)" do
      before do
        visit '/users/sign_in'
        fill_in "user_email", with: not_reception_user.email
        fill_in "user_password", with: not_reception_user.password
        click_on "Log In"
        visit '/users/' + reception_user.id.to_s
      end
      context "リンクの表示" do
        it "フォローするリンクが存在する" do
          expect(page).to have_link "フォローする"
        end
      end
    end
  end
  describe "ユーザー詳細画面(users/edit)のテスト" do
    before do
      visit '/users/sign_in'
      fill_in "user_email", with: reception_user.email
      fill_in "user_password", with: reception_user.password
      click_on "Log In"
      visit '/users/' + reception_user.id.to_s + '/edit'
    end
    context ""
  end
end