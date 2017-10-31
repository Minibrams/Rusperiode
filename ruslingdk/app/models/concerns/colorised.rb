require 'active_support/concern'

module Colorised
  extend ActiveSupport::Concern

  def background_color
    self.colors['background_color'] || '#dddddd'
  end
end
