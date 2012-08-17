class AssertionFailure < StandardError
end

class Object
  def assert_equal(s1, s2, message='assertion failure')
    if $AVLUSA
      raise AssertionFailure.new(message) if s1!=s2 
    end
  end

  def assert_not_equal(s1, s2, message="-#{s1} and #{s2} is equal-")
    raise AssertionFailure.new(message) if s1==s2 
  end

  def assert_not_nil(s, message="-#{s} is nil-")
    raise AssertionFailure.new(message) if s == nil 
  end
end
