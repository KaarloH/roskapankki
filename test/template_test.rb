require "test_helper"

class TemplateTest < Minitest::Test

  def template
    @template ||= Roskapankki::UI::Template.new("bank")
  end

  def test_renders_template
    result = template.render
    assert result
    assert_includes result, "<h1>Roskapankki</h1>"
  end
end
