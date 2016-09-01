class Comment < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Comment, :create

    contract do
      def self.weights
        { '0' => 'Nice!', '1' => 'Rubbish!' }
      end

      def weights
        [self.class.weights.to_a, :first, :last]
      end

      property :body
      property :weight, prepopulator: ->(*) { self.weight = '0' }
      property :thing

      validates :body, length: { in: 6..160 }
      validates :weight, inclusion: { in: weights.keys }
      validates :thing, :user, presence: true

      property :user,
        prepopulator: ->(*) { self.user = User.new },
        populate_if_empty: User do
        property :email
        validates :email, presence: true, email: true
      end
    end

    def process(params)
      validate(params[:comment], &:save)
    end

    def thing
      model.thing
    end

    private

    def setup_model!(params)
      model.thing = Thing.find(params[:thing_id])
    end
  end
end
