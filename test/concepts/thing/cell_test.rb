require 'test_helper'
class Thing < ActiveRecord::Base
  class CellTest < ::Cell::TestCase
    controller ThingsController

    let(:rails) { Thing::Create.(thing: {name: 'Rails'}) }
    let(:trb){ Thing::Create.(thing: {name: 'Trailblazer'}) }
    subject {
      binding.pry
      concept('thing/cell', collection: [trb, rails], last: rails).model
    }

    it do
      subject.must_have_selector '.columns .header a', text: 'Rails'
      subject.must_not_have_selector '.columns.end .header a', text: 'Rails'
      subject.must_have_selector '.columns.end .header a', text: 'Trailblazer'
    end
  end
end
