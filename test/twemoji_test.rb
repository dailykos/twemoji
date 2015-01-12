require "test_helper"

class TwemojiTest < Minitest::Test
  def setup
    @option = {}
  end

  def test_find_by_text
    assert_equal "1f60d", Twemoji.find_by_text(":heart_eyes:")
  end

  def test_find_by_code
    assert_equal ":heart_eyes:", Twemoji.find_by_code("1f60d")
  end

  def test_finder_methods_find_by_text
    assert_equal "1f60d", Twemoji.find_by(text: ":heart_eyes:")
  end

  def test_finder_methods_find_by_code
    assert_equal ":heart_eyes:", Twemoji.find_by(code: "1f60d")
  end

  def test_emoji_pattern
    assert_kind_of Regexp, Twemoji.emoji_pattern
  end

  def test_parse_html_string
    expected = "I like chocolate <img class='emoji' draggable='false' title=':heart_eyes:' alt=':heart_eyes:' src='https://twemoji.maxcdn.com/svg/1f60d.svg'>!"

    assert_equal expected, Twemoji.parse("I like chocolate :heart_eyes:!")
  end

  def test_parse_document
    doc  = Nokogiri::HTML::DocumentFragment.parse("<p>I like chocolate :heart_eyes:!</p>")
    expected = '<p>I like chocolate <img class="emoji" draggable="false" title=":heart_eyes:" alt=":heart_eyes:" src="https://twemoji.maxcdn.com/svg/1f60d.svg">!</p>'

    assert_equal expected, Twemoji.parse(doc).to_html
  end

  def test_parse_option_cdn
    expected = "I like chocolate <img class='emoji' draggable='false' title=':heart_eyes:' alt=':heart_eyes:' src='https://emoji.bestcdn.com/svg/1f60d.svg'>!"

    assert_equal expected, Twemoji.parse("I like chocolate :heart_eyes:!", asset_root: 'https://emoji.bestcdn.com')
  end

  def test_parse_option_file_ext
    expected = "I like chocolate <img class='emoji' draggable='false' title=':heart_eyes:' alt=':heart_eyes:' src='https://twemoji.maxcdn.com/16x16/1f60d.png'>!"

    assert_equal expected, Twemoji.parse("I like chocolate :heart_eyes:!", file_ext: '.png')
  end
end
