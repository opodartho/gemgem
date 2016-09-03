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
      include ActionView::Helpers::JavaScriptHelper
      include Kaminari::Cells
      inherit_views Comment::Cell

      def show
        render :grid
      end

      def append
        %{ $("#next").replaceWith("#{j(show)}") }
      end

      private

      def comments
        @comments ||= model.comments.includes(:user).page(page).per(5)
      end

      def page
        options[:page] || 1
      end
    end
  end
end
