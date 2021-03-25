# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効なユーザーが保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
  
  context 'Userバリデーションチェック' do
    it 'account_nameが空白時にエラーメッセージが表示される' do
      user = User.new(account_name: '',
                      email:'test@example.com',
                      password: "000000",
                      is_reception: "true")
	    expect(user).to be_invalid
	    expect(user.errors[:account_name]).to include("を入力してください")
    end
    it 'account_nameが重複' do
      unique_user = FactoryBot.build(:user)
      unique_user.save
      unique_user2 = FactoryBot.build(:user)
      unique_user2.account_name = unique_user.account_name
      expect(unique_user2).not_to be_valid
    end
    it 'emailが重複' do
      unique_user = FactoryBot.build(:user)
      unique_user.save
      unique_user2 = FactoryBot.build(:user)
      unique_user2.email = unique_user.email
      expect(unique_user2).not_to be_valid
    end
  end
end