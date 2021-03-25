# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostImage, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効な投稿が保存されるか" do
      expect(FactoryBot.build(:post_image)).to be_valid
    end
  end
  
  context 'PostImageのバリデーションチェック' do
    it 'titleが空白' do
      post_image = FactoryBot.build(:post_image)
      post_image.title = ""
	    expect(post_image).to be_invalid
	    expect(post_image.errors[:title]).to include("を入力してください")
    end
    it '画像が空白' do
      post_image = FactoryBot.build(:post_image)
      post_image.image = ""
	    expect(post_image).to be_invalid
	    expect(post_image.errors[:image]).to include("を入力してください")
    end
  end
end