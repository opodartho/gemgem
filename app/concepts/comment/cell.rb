class Comment < ActiveRecord::Base
  class Cell < ::Cell::Concept
    property :body
    property :created_at
    property :user

    include ::Gemgem::Cell::GridCell
    include ::Gemgem::Cell::CreatedAt
    self.classes = %w(comment large-4 columns)

    def show
      render
    end

    private

    def nice?
      model.weight == 0
    end

    class Grid < ::Cell::Concept
      include Kaminari::Cells

      def show
        concept(
          'comment/cell',
          collection: comments,
          last: comments.last
        ).call + paginate(comments)
      end

      private

      def comments
        @comments ||= model.comments.page(page).per(3)
      end

      def page
        options[:page] || 1
      end
    end
  end
end
