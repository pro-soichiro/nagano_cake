class Public::CustomersController < ApplicationController
  def show
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(current_customer)
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      render :show
    end
  end
  private

  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :last_name_kana,
                                     :first_name_kana,
                                     :postal_code,
                                     :address,
                                     :telephone_number,
                                     :email,
                                     :is_deleted)
  end
end
