class DocumentsGenerator::ApplicationRecord < ::ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :documents_generator }
end
