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
      include WillPaginate::ActionView

      def show
        ct = content_tag :div, class: 'row' do
          concept(
            'comment/cell',
            collection: comments,
            last: comments.last
          )
        end
        ct + will_paginate(comments)
      end

      private

      def comments
        @comments ||= model.comments.includes(:user).paginate(page: page, per_page: 5)
      end

      def page
        options[:page] || 1
      end
    end
  end
end
