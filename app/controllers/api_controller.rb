class ApiController < ApplicationController
    # equivalent of authenticate_user! on device, but this one will check the oauth token
    # before_action: authenticate_user
    before_action :doorkeeper_authorize!

    # Skip checking CSRF token authenticity for API requests 
    skip_before_action :verify_authenticity_token

    # Set response type
    respond_to :json

    # hepler method to access the current user from the token
    def current_user
        return unless doorkeeper_token
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id]) 
    end  
end