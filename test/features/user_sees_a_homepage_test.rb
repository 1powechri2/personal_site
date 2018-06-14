require './test/test_helper'

class HomepageTest < CapybaraTestCase
  def test_user_can_see_the_homepage
    visit '/'

    assert page.has_content?('ROCK')
    assert_equal 200, page.status_code
  end

  def test_user_can_see_an_error_message
    visit '/plop'

    assert page.has_content?('Page not found.')
    assert_equal 404, page.status_code
  end

  def test_user_can_see_rock
    visit '/rock'

    assert page.has_content?('ROCK!')
    assert_equal 200, page.status_code
  end

  def test_rock_on_link
    visit '/'
    click_on "ROCK ON"

    assert_equal 200, page.status_code
    assert_equal '/rock', current_path
    assert page.has_content?("ROCK!")
  end
end
