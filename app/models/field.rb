class Field < ApplicationRecord
  belongs_to :step

  serialize :contents, JSON

  before_validation :init_contents

  def init_contents
    self.contents = {} if contents.blank?
  end
end
