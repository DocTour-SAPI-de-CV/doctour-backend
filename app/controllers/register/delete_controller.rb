# frozen_string_literal: true

module Register
  class DeleteController < ApplicationController
    def self.objects(objects)
      unless objects.empty?
        objects.each do |object|
          object[1].delete
        end
      end
    end
  end
end
