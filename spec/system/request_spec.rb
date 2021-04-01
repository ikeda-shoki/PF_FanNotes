# frozen_string_literal: true

require 'rails_helper'

describe 'Requestのテスト' do
  let!(:test_user){ FactoryBot.create(:test_user) }
  let!(:requested_user){ FactoryBot.create(:test_user) }
  let!(:requesting_user){ FactoryBot.create(:not_reception_user) }

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
          deadline: "2022/05/20",
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
      end
      context '遷移先のテスト' do
        it 'request情報の遷移先は正しいか' do
          request_info = find('.requesting_request_repec')
          request_info.click
          expect(current_path).to eq('/users/' + requested_user.id.to_s + '/requesting_show/' + test_request.id.to_s )
        end
      end
    end

    describe 'リクエスト(requested)のテスト' do
      let!(:test_request) {
        Request.create(
          #先ほどのテストとは違い、requester_idをrequestr_user.idで登録しています。
          requester_id: requesting_user.id,
          requested_id: test_user.id,
          request_introduction: "アイコン作成の依頼",
          file_format: "jpg",
          use: '自分のSNSアカウントで使用する予定です。',
          amount: "1",
          deadline: "2022/05/10",
          request_status: "未受付")
      }

      describe 'リクエスト(request/requested)のテスト' do

        before do
          visit '/users/' + test_user.id.to_s + '/requested'
        end

        context '表示の確認' do
          it 'user-profileが存在する' do
            expect(page).to have_css('.user-profile')
          end
          it 'request情報が存在する' do
            expect(page).to have_css('.requests')
          end
          it 'request情報、requesting_userの名前が存在する' do
            expect(page).to have_content test_request.requester.account_name
          end
          it 'request情報、requested数が存在する' do
            expect(page).to have_content test_user.requested.count
          end
          it 'request情報、request_statusが存在する' do
            expect(page).to have_content test_request.request_status
          end
        end
        context '遷移先のテスト' do
          it 'request情報の遷移先は正しいか' do
            request_info = find('.requested_request_repec')
            request_info.click
            expect(current_path).to eq('/users/' + requesting_user.id.to_s + '/requested_show/' + test_request.id.to_s )
          end
        end

      end

      describe 'リクエスト(request/requested_show)のテスト' do

        before do
          visit '/users/' + requesting_user.id.to_s + '/requested_show/' + test_request.id.to_s
        end

        context '表示の依頼' do
          it 'requesting_userの名前が表示されている' do
            expect(page).to have_content requesting_user.account_name
          end
          it 'requestの内容詳細が表示されている' do
            expect(page).to have_content test_request.request_introduction
          end
          it 'requestの内容詳細が表示されている' do
            expect(page).to have_content test_request.request_introduction
          end
          it 'requestの参考画像が表示されている' do
            expect(page).to have_css('.reference_image')
          end
          it 'requestのファイル形式が表示されている' do
            expect(page).to have_content test_request.file_format
          end
          it 'requestの用途が表示されている' do
            expect(page).to have_content test_request.use
          end
          it 'requestの用途が表示されている' do
            expect(page).to have_content test_request.use
          end
          it 'requestの枚数が表示されている' do
            expect(page).to have_content test_request.amount
          end
          it 'requestの納期が表示されている' do
            expect(page).to have_css('.request-show-deadline')
          end
          it 'requestの受付状況が表示されている' do
            expect(page).to have_content test_request.request_status
          end
          it 'requestの一覧画面に戻るが表示されている' do
            expect(page).to have_link "一覧画面に戻る"
          end
          it 'requestのチャットボタンが表示されている' do
            expect(page).to have_link("チャットを始める")
          end
        end

        context '製作ステータスが未受付の時、フォームの確認' do
          it 'requestの登録するが表示されている' do
            expect(page).to have_button "登録する"
          end
          it 'requestのrequest_statusが製作するが初めから選択されている' do
            expect(page).to have_checked_field with: '製作中', visible: false
          end
          it 'requestのrequest_statusが製作するを選択すると製作中に変更される' do
            click_button '登録する'
            expect(page).to have_content('製作中')
          end
          it 'requestのrequest_statusで製作しないを選択すると受付不可に変更される' do
            find('label[for=request_request_status_受付不可]').click
            expect(page).to have_checked_field with: '受付不可', visible: false
            click_button '登録する'
            expect(page).to have_content('受付不可')
          end
          it '製作ステータスの更新後のアラートは正しいか' do
            #inputをcssでdisplay:noneにしている為
            click_button '登録する'
            expect(page).to have_content("製作ステータスを更新しました")
          end
          it '製作ステータスの更新先は正しいか' do
            click_button '登録する'
            expect(current_path).to eq("/users/" + test_user.id.to_s + "/requested")
          end
        end
      end
    end

  end
end