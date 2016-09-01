require 'test_helper'
class Thing < ActiveRecord::Base
  class CellTest < ::Cell::TestCase
    controller ThingsController

    let(:rails) { Thing::Create.call(thing: { name: 'Rails' }).model }
    let(:trb) { Thing::Create.call(thing: { name: 'Trailblazer' }).model }
    subject do
      concept('thing/cell', collection: [trb, rails], last: rails).call
    end

    it do
      subject.must_have_selector '.columns .header a', text: 'Rails'
      subject.must_have_selector '.columns.end .header a', text: 'Rails'
      subject.wont_have_selector '.columns.end .header a', text: 'Trailblazer'
    end
  end
end
