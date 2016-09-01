require 'test_helper'

class Thing < ActiveRecord::Base
  class UpdateTest < MiniTest::Spec
    describe 'Update' do
      let(:thing) do
        Thing::Create.call(
          thing: { name: 'Rails', description: 'Kickass web dev' }
        ).model
      end

      it 'persists valid, ignores name' do
        Thing::Update.call(
          id:
          thing.id,
          thing: {
            name:
            'Lotus',
            description: 'Simply better..'
          }
        )

        thing.reload
        thing.name.must_equal 'Rails'
        thing.description.must_equal 'Simply better..'
      end
    end
  end
end
