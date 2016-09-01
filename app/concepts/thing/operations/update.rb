class Thing < ActiveRecord::Base
  class Update < Create
    action :update

    contract do
      property :name, writeable: false
    end
  end
end
