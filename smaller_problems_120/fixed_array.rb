class FixedArray

  def initialize(arr_size)
    @arr = Array.new(arr_size)
  end

  def [](idx)  # checks out / works
    @arr[idx]
  end

  def []=(idx, el) # checks out / works
    @arr[idx] = el
  end

  def to_a # checks
    @arr.clone
  end

  def to_s
    @arr.to_s
  end
end