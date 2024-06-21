require 'test_helper'

class DocumentsGenerator::CommunityTest < ActiveSupport::TestCase
  setup do
    @community = documents_generator_communities(:one)
    @document_one = documents_generator_documents(:one)
  end

  test "should have many documents" do
    assert_respond_to @community, :documents
    assert_equal 1, @community.documents.count
  end

  test "should return associated documents" do
    assert_includes @community.documents, @document_one
  end

  test "should allow adding documents" do
    new_document = ::DocumentsGenerator::Document.create!(
      template_name: nil,
      content: "",
      community: @community
    )
    assert_includes @community.documents, new_document
    assert_equal 2, @community.documents.count
  end

  test "should destroy associated documents when community is destroyed" do
    community = documents_generator_communities(:two)
    document = documents_generator_documents(:two)
    assert_difference('DocumentsGenerator::Document.count', -1) do
      community.destroy
    end
    assert_nil ::DocumentsGenerator::Document.find_by(id: document.id)
  end
end
