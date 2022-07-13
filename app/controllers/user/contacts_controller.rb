class User::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    #問い合わせ内容の確認を行い、送信ボタンを押すことでcreateへ送信
    @contact = Contact.new(contact_params)
  end

  def back
    #問い合わせ内容に誤りがあれば、戻るボタンを押すことで再度フォームへ戻る
    @contact = Contact.new(contact_params)
    render :new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver_now
      redirect_to thanks_contacts_path
    else
      render :new
    end
  end

  def thanks
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end

end
