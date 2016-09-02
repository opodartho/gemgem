require 'test_helper'
class ThingIntegrationTest < Trailblazer::Test::Integration
  it 'allows anonymous' do
    visit '/things/new'

    page.must_have_css 'form #thing_name'
    page.wont_have_css 'form #thing_name.readonly'

    # invalid.
    click_button 'Create Thing'
    page.must_have_css '.error'

    # correct submit.
    fill_in 'Name', with: 'Bad Religion'
    click_button 'Create Thing'

    # show
    page.current_path.must_equal thing_path(Thing.last)
    page.body.must_match(/Bad Religion/)

    # edit
    thing = Thing.last
    visit "/things/#{thing.id}/edit"
    page.must_have_css "form #thing_name.readonly[value='#{thing.name}']"
  end
end
