class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  # 確認画面を介してお問い合わせ内容が送信されるようにする
  def confirm
    @contact = Contact.new
    @contact.name = params[:contact][:name]
    @contact.email = params[:contact][:email]
    @contact.phone_number = params[:contact][:phone_number]
    @contact.subject = params[:contact][:subject]
    @contact.message = params[:contact][:message]
  end

  # 入力に誤りがあった場合、入力情報を保持したまま前のページに遷移する
  def back
    @contact = Contact.new(contact_params)
    render "new"
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      render "new"
    end
  end

  # 送信完了画面
  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone_number, :subject, :message)
  end
end
