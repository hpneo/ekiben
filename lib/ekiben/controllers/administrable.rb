module Bentou
  module Controllers
    module Administrable

      extend ActiveSupport::Concern
      included do 
        layout 'admin'
    		respond_to :xml, :json, :html, :js
      	before_filter :authenticate_user!
    	end
    end
  end
end