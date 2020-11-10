# frozen_string_literal: true

class ApplicationFinder
  def find
    @scope
  end

  private

  def initialize(initial_scope)
    @scope = initial_scope
  end
  attr_reader :scope
end
