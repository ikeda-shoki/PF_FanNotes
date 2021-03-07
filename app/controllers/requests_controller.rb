class RequestsController < ApplicationController

  def new
    @user = User.find_by(id: params[:user_id])
    @request = Request.new
  end
  
  #自分の依頼一覧画面
  def requesting
    @requests = current_user.request
    @requests.each do |request|
      @requested = request.requested
    end
  end

  #自分に来ている依頼
  def requested
    @requests = current_user.requested
    @requests.each do |request|
      @requester = request.requester
    end
  end

  #自分の依頼詳細画面
  def requesting_show
    @request = Request.find(params[:id])
  end

  #自分に来ている依頼詳細画面
  def requested_show
    @request = Request.find(params[:id])
  end

  #依頼終了画面
  def request_done
    @request = Request.find(params[:id])
  end

  #依頼完了画面
  def request_complete
    @request = Request.find(params[:id])
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @request = Request.new(request_params)
    @request.requested_id = @user.id
    if @request.save
      flash[:notice] = '依頼が成功しました'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    
  end

  # request_show画面でのrequest_statusのみの更新
  def update_request_status
    @request = Request.find(params[:id])
    @request_user = User.find_by(id: params[:user_id])
    if @request.update(request_update_params)
      redirect_to user_requested_path(current_user)
    else
      render 'show'
    end
  end
  
  #完成した画像を登録する際に使用
  def update_request_complete_image
    @request = Request.find(params[:id])
    if @request.update(complete_image_update_params)
      redirect_to user_request_done_path(user_id: @request.requester, id: @request)
    else
      render 'requested_show'
    end
  end

  def destroy
    if Request.find(params[:id]).destroy
      redirect_to user_requested_path(current_user)
    else
      render 'show'
    end
  end

  private
   def request_params
     params.require(:request).permit(:request_introduction,
                                     :reference_image,
                                     :file_format,
                                     :use,
                                     :deadline,
                                     :amount,
                                     :requester_id).merge(requester_id: current_user.id)
   end

   def request_update_params
     params.require(:request).permit(:request_status)
   end
   
   def complete_image_update_params
     params.require(:request).permit(:request_status, :complete_image).merge(request_status: "製作完了")
   end
end
