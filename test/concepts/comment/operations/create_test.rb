require 'test_helper'
class Thing < ActiveRecord::Base
  class CreateTest < MiniTest::Spec
    let(:thing) { Thing::Create.call(thing: { name: 'Ruby' }).model }

    describe '#Create' do
      it 'persists valid' do
        res, op = Comment::Create.run(
          comment: {
            body:
            'Fantastic!',
            weight: '1',
            user:
            { email: 'jonny@trb.org' }
          },
          thing_id: thing.id
        )
        res.must_equal true
        comment = op.model
        comment.persisted?.must_equal true
        comment.body.must_equal 'Fantastic!'
        comment.weight.must_equal 1
        comment.user.persisted?.must_equal true
        comment.user.email.must_equal 'jonny@trb.org'
        op.thing.must_equal thing
      end

      it 'invalid email' do
        res, operation = Comment::Create.run(
          comment: {
            user:
            { email: '1337@' }
          },
          thing_id: thing.id
        )
        res.must_equal false
        operation.errors.messages[:'user.email'].must_equal ['is invalid']
      end
    end
  end
end
