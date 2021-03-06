module UsersHelper
  def reception?(user)
    user.is_reception?
  end
  
  # 依頼状況の表示
  def reception_status(user)
    if user.is_reception === true
      "依頼受付中"
    else
      "依頼不可"
    end
  end
  
end
