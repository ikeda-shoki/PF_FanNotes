# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, "モデルに関するテスト", type: :model do
  describe "フォローできるか" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_user) { FactoryBot.create(:test_user) }
    let(:relationship) { user.follower.build(followed_id: test_user.id) }
    
    it "テストフォローデータは有効か" do
      expect(relationship).to be_valid
    end
    
    describe "バリデーションエラー" do
      it "follower_idがない場合" do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
      it "followed_idがない場合" do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end
    end
  end
  
end