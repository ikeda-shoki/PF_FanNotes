# frozen_string_literal: true

require 'rails_helper'

describe 'Requestのテスト' do
  let!(:test_user){ FactoryBot.create(:test_user) }
  let!(:requested_user){ FactoryBot.create(:test_user) }

  describe 'リクエストする時のテスト' do

    before do
      visit '/users/sign_in'
      fill_in "user_email", with: test_user.email
      fill_in "user_password", with: test_user.password
      click_on "Log In"
    end

    describe 'リクエスト(request/new)のテスト' do
      before do
        visit '/users/' + requested_user.id.to_s + '/requests/new'
      end

      it 'タイトルに相手の名前が表示されている' do
        expect(page).to have_content requested_user.account_name
      end
      it 'リクエストが保存されるか' do
        expect do
          fill_in "request_request_introduction", with: Faker::Book.title
          select 'jpg', from: 'ファイル形式'
          fill_in "request_use", with: Faker::Book.title
          fill_in "request_deadline", with: "2021/05/20"
          click_button '依頼を送信する'
        end.to change(Request.all, :count).by(1)
      end
      it 'リクエストが保存された時アラートが表示されるか' do
        fill_in "request_request_introduction", with: Faker::Book.title
        select 'jpg', from: 'ファイル形式'
        fill_in "request_use", with: Faker::Book.title
        fill_in "request_deadline", with: "2021/05/20"
        click_button '依頼を送信する'
        expect(page).to have_content(requested_user.account_name + 'に依頼を送信しました')
      end
      it 'リクエストを送信した遷移先は正しいか' do
        fill_in "request_request_introduction", with: Faker::Book.title
        select 'jpg', from: 'ファイル形式'
        fill_in "request_use", with: Faker::Book.title
        fill_in "request_deadline", with: "2021/05/20"
        click_button '依頼を送信する'
        expect(current_path).to eq('/users/' + test_user.id.to_s )
      end
    end

    describe 'リクエスト(request/requesting)のテスト' do
      let!(:test_request) {
        Request.create(
          requester_id: test_user.id,
          requested_id: requested_user.id,
          request_introduction: "アイコン作成の依頼",
          file_format: "jpg",
          use: '自分のSNSアカウントで使用する予定です。',
          amount: "1",
          deadline: "2021/04/20",
          request_status: "未受付")
      }

      before do
        visit '/users/' + test_user.id.to_s + '/requesting'
      end

      context '表示の確認' do
        it 'user-profileが存在する' do
          expect(page).to have_css('.user-profile')
        end
        it 'request情報が存在する' do
          expect(page).to have_css('.requests')
        end
        it 'request情報、requested_userの名前が存在する' do
          expect(page).to have_content test_request.requested.account_name
        end
        it 'request情報、requests数が存在する' do
          expect(page).to have_content test_user.request.count
        end
        it 'request情報、request_statusが存在する' do
          expect(page).to have_content test_request.request_status
        end
        it 'request情報、user.profile_imageが存在する' do
          expect(page).to have_content test_request.requested.profile_image
        end
      end
    end
  end


end