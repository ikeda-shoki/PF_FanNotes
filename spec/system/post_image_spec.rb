# frozen_string_literal: true

require 'rails_helper'

describe 'PostImageのテスト' do
  describe 'top(top_path)のテスト' do
    before do
      visit '/'
    end

    context "リンクの確認" do
      it 'logoをのリンク先は正しいか' do
        logo_link = find_all('a')[0]
        logo_link.click
        expect(current_path).to eq('/post_images/main')
      end
      it 'Log Inリンクがあるか' do
        expect(page).to have_link 'ログイン'
      end
      it 'Log Inのリンク先は正しいか' do
        log_in_link = find_all('a')[6]
        log_in_link.click
        expect(current_path).to eq('/users/sign_in')
      end
      it 'Log Inリンク先は正しいか_2' do
        log_in_link = find_all('a')[8]
        log_in_link.click
        expect(current_path).to eq('/users/sign_in')
      end
      it 'Sign Upリンクがあるか' do
        expect(page).to have_link '新規登録'
      end
      it 'Sign Upのリンク先は正しいか' do
        sign_up_link = find_all('a')[7]
        sign_up_link.click
        expect(current_path).to eq('/users/sign_up')
      end
      it 'Sign Upリンク先は正しいか_2' do
        sign_up_link = find_all('a')[9]
        sign_up_link.click
        expect(current_path).to eq('/users/sign_up')
      end
      it 'ゲストログインリンクがあるか' do
        expect(page).to have_link 'ゲストログイン'
      end
      it 'ゲストログインリンクでログインできるか' do
        gest_log_in_link = find_all('a')[10]
        gest_log_in_link.click
        expect(page).to have_content("ゲストユーザーとしてログインしました")
      end
      it 'mainページへのリンクがあるか' do
        expect(page).to have_link '作品を見にいこう'
      end
      it 'mainリンクのリンク先は正しいか' do
        main_link = find_all('a')[11]
        main_link.click
        expect(current_path).to eq('/post_images/main')
      end
      it 'mainリンクのリンク先は正しいか_2' do
        main_link = find_all('a')[12]
        main_link.click
        expect(current_path).to eq('/post_images/main')
      end
    end
  end

  describe 'PostImageのテスト(ログイン済)' do
    let!(:test_user) { FactoryBot.create(:test_user) }

    before do
      visit '/users/sign_in'
      fill_in "user_email", with: test_user.email
      fill_in "user_password", with: test_user.password
      click_on "Log In"
    end

    context "ヘッダーの表示" do
      it "ヘッダーの表示が変わっている" do
        expect(page).to have_link '投稿する'
        expect(page).to have_link 'マイページ'
        expect(page).to have_link '通知'
        expect(page).to have_link 'メイン画面'
        expect(page).to have_link 'イラスト一覧'
        expect(page).to have_link 'ユーザー一覧'
        expect(page).to have_link 'ログアウト'
      end
    end

    describe "メイン(main_path)のテスト" do
      it "作品一覧のリンクがあるか" do
        expect(page).to have_link '作品一覧へ'
      end
      it "ユーザー一覧のリンクがあるか" do
        expect(page).to have_link 'ユーザー一覧へ'
      end
    end

    describe "投稿(post_images/new)のテスト" do
      before do
        visit '/post_images/new'
      end

      context '投稿が保存できた時' do
        it "投稿が保存される" do
          expect do
            fill_in "post_image_title", with: Faker::Book.title
            fill_in "post_image_image_introduction", with: Faker::Book.title
            find("input[type='file']").click
            attach_file "post_image_image", "app/assets/images/illust_1.jpg"
            click_button '投稿する'
          end.to change(test_user.post_images, :count).by(1)
        end
        it "投稿が保存された後の遷移先" do
          fill_in "post_image_title", with: Faker::Book.title
          fill_in "post_image_image_introduction", with: Faker::Book.title
          find("input[type='file']").click
          attach_file "post_image_image", "app/assets/images/illust_1.jpg"
          click_button '投稿する'
          expect(current_path).to eq('/users/' + test_user.id.to_s)
        end
        it "ハッシュタグができているかの確認" do
          expect do
            fill_in "post_image_title", with: Faker::Book.title
            fill_in "post_image_image_introduction", with: "#イラスト"
            find("input[type='file']").click
            attach_file "post_image_image", "app/assets/images/illust_1.jpg"
            click_button '投稿する'
          end.to change(Hashtag.all, :count).by(1)
        end
      end
    end

    describe "投稿(post_images/show)のテスト" do
      let!(:post_image) do
        FactoryBot.create(:post_image)
      end

      before do
        visit "/post_images/" + post_image.id.to_s
      end

      context "リンクのテスト" do
        it "いいねのリンクは存在するか" do
          expect(page).to have_css(".fa-heart")
        end
        it "投稿コメントを入力する場所は存在するか" do
          expect(page).to have_field "post_image_comment[comment]"
        end
        it "投稿コメントの送信ボタンは存在するか" do
          expect(page).to have_button("送信")
        end
        it "プロフィールボタンは存在するか" do
          expect(page).to have_link("プロフィールへ")
        end
        it "フォローボタンは存在するか" do
          unless post_image.user === test_user
            if test_user.following?(post_image.user)
              expect(page).to have_link "フォローを外す"
            else
              expect(page).to have_link "フォローする"
            end
          end
        end
        it "プロフィールボタンの遷移先は正しいか" do
          click_link("プロフィールへ")
          expect(current_path).to eq("/users/" + post_image.user_id.to_s)
        end
        it "投稿の編集リンクは存在するか" do
          if post_image.user === test_user
            expect(page).to have_link("投稿を編集する")
          end
        end
        it "投稿の編集リンク先は正しいか" do
          if post_image.user === test_user
            click_link("投稿を編集する")
            expect(current_path).to eq("/post_images/" + post_image.id.to_s + "/edit")
          end
        end
      end
    end

    describe "投稿編集(post_images/edit)のテスト" do
      let!(:post_image) do
        FactoryBot.create(:post_image)
      end

      before do
        visit "/post_images/" + post_image.id.to_s + "/edit"
      end

      context "更新のテスト" do
        it "更新するボタンは存在するか" do
          expect(page).to have_button("更新する")
        end
        it "更新を削除するボタンは存在するか" do
          expect(page).to have_link("投稿を削除する")
        end
        it "更新できるか" do
          fill_in "post_image_title", with: post_image.title
          fill_in "post_image_image_introduction", with: "#イラスト"
          find("input[type='file']").click
          attach_file "post_image_image", "app/assets/images/illust_1.jpg"
          click_button '更新する'
          expect(page).to have_content('更新しました')
        end
        it "更新先は正しいか" do
          fill_in "post_image_title", with: post_image.title
          fill_in "post_image_image_introduction", with: "#イラスト"
          find("input[type='file']").click
          attach_file "post_image_image", "app/assets/images/illust_1.jpg"
          click_button '更新する'
          expect(current_path).to eq('/post_images/' + post_image.id.to_s)
        end
        it "削除できるか" do
          expect do
            click_link "投稿を削除する"
          end.to change(PostImage.all, :count).by(-1)
        end
      end
    end
  end
end
