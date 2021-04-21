# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効なメッセージが保存されるか" do
      expect(FactoryBot.build(:chat)).to be_valid
    end
  end

  describe 'Chatのバリデーションチェック' do
    it 'messageが空白' do
      chat = FactoryBot.build(:chat)
      chat.message = ""
      expect(chat).to be_invalid
      expect(chat.errors[:message]).to include("を入力してください")
    end
  end
end
