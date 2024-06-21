class DocumentsGenerator::Community < DocumentsGenerator::ApplicationRecord
  has_many :documents, dependent: :destroy
end
