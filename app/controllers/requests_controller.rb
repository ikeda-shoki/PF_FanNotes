class RequestsController < ApplicationController

  def new
    @user = User.find_by(id: params[:user_id])
    @request = Request.new
  end

  def show
  end

  def edit
  end

  def request_done
  end

  def request_complete
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

  def update
  end

  def destroy
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
end
