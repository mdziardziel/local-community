require 'test_helper'

class DocumentsGenerator::DocumentTest < ActiveSupport::TestCase
  setup do
    @document = documents_generator_documents(:one)
    @community = documents_generator_communities(:one)
  end

  test "should be valid with valid attributes" do
    assert @document.valid?
  end

  test "should belong to a community" do
    assert_respond_to @document, :community
    assert_equal @community, @document.community
  end
end
