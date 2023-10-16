class PagesController < ApplicationController
  def home
    @application = Doorkeeper::Application.find_by(name: 'Web Client')
    # @application = Doorkeeper::Application.where(name: 'Web Client').first

    @application = {
      name: @application.name,
      client_id: @application.uid,
      client_secret: @application.secret
    }

    # render plain:  @application
  end
end
