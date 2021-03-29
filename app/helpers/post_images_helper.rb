module PostImagesHelper
  # post_image_showで使用（ハッシュタグの付いた投稿一覧へのリンク）
  def render_with_hashtags(post_image_introduction)
    post_image_introduction.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, hashtag_path(name: word.delete("#＃"))}.html_safe
  end
end