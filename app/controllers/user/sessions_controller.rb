# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected

  # 退会済みの場合は同じアカウントでは利用できない。
  def reject_user
    #ログイン時に入力されたemailにがいとうするユーザーがいるか確認
    @user = User.find_by(name: params[:user][:email])
    if @user
      #入力されたパスワードが正しいか確認して、モデルに記述したactive_for_authenticationがfalseであれば退会済みユーザーと断定する
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。再度新規登録を行なってください。"
        redirect_to new_user_registration
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
end
