class BSTNode
  attr_reader :value, :left, :right, :parent
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def left=(left)
    @left = left
  end

  def right=(right)
    @right = right
  end

end
