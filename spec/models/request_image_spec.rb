# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RequestImage, "モデルに関するテスト", type: :model do
  describe '実際に保存する' do
    it "有効な完成イラストが保存されるか" do
      expect(FactoryBot.build(:request_image)).to be_valid
    end
  end

  context 'RequestImageのバリデーションチェック' do
    it 'complete_imageが空白のまま保存されない' do
      request_image = FactoryBot.build(:request_image)
      request_image.complete_image = ""
	    expect(request_image).not_to be_valid
    end
  end
end