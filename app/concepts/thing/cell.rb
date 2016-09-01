class Thing < ActiveRecord::Base
  class Cell < ::Cell::Concept
    include ::ActionView::Helpers::DateHelper
    include ::Rails::Timeago::Helper

    property :name
    property :created_at

    def show
      render
    end

    private

    def classes
      classes = %w(large-3 columns)
      classes << 'end' if options[:last].eql? model
      classes
    end

    def name_link
      link_to name, thing_path(model)
    end

    def created_at
      timeago_tag super
    end

    class Grid < ::Cell::Concept
      def show
        things = Thing.latest
        concept('thing/cell', collection: things, last: things.last)
      end
    end
  end
end
