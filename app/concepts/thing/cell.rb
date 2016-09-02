class Thing < ActiveRecord::Base
  class Cell < ::Cell::Concept
    property :name
    property :created_at

    include ::Gemgem::Cell::CreatedAt
    include ::Gemgem::Cell::GridCell
    self.classes = %w(thing large-3 columns)

    def show
      render
    end

    private

    def name_link
      link_to name, thing_path(model)
    end

    class Grid < ::Cell::Concept
      def show
        things = Thing.latest
        concept('thing/cell', collection: things, last: things.last)
      end
    end
  end
end
