class TestRepository
  include ::Hexagram::Repositories::Repository
end

class TestEntity
  def valid?(repo)
  end
end
