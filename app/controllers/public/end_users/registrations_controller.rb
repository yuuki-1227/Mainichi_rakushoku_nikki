# frozen_string_literal: true

class Public::EndUsers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    posts_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :kana_first_name, :kana_last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :kana_last_name, :kana_first_name, :is_deleted, :introduction, :profile_images])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
