class Authentication::ApplicationRecord < ::ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :authentication }
end
