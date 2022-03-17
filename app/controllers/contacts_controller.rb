class ContactsController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def new
    @contact = Contact.new
  end

  # 作成したメールオブジェクト(contact_mail)のdeliverメソッドを呼び出すことで、メールの送信が行えます。
  # deliver_laterでコントローラは送信完了を待たずに処理を続行できます.
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver_later
      redirect_to complete_contacts_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email,:phone_number, :content)
  end
end
