class ApplicationController < ActionController::Base
  # before_action :authenticate_customer!, if: :use_auth?
  # before_action :authenticate_admin!, if: :admin_use_auth?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      items_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :customer
          root_path
      elsif resource_or_scope == :admin
          new_admin_session_path
      else
          root_path
      end
  end

  # def after_sign_out_path_for(resource)
  #   case resource
  #   when Admin
  #     new_admin_session_path
  #   when Customer
  #     items_path
  #   end
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
                                                [:last_name,
                                                :first_name,
                                                :last_name_kana,
                                                :first_name_kana,
                                                :postal_code,
                                                :address,
                                                :telephone_number,
                                                :is_deleted])
  end

  # private

  # def use_auth?
  #   unless controller_name == 'public/sessions' && action_name == 'new'
  #     true
  #   end
  #   unless controller_name == 'public/registrations' && action_name == 'new'
  #     true
  #   end
  #   unless controller_name == 'public/items' && action_name == 'index'
  #     true
  #   end
  #   unless controller_name == 'public/items' && action_name == 'show'
  #     true
  #   end
  # end

  # def admin_use_auth?
  #   unless controller_name == 'admin/sessions' && action_name == 'new'
  #     true
  #   end
  # end
end
