module TypeList

  TYPES = {
    integer: Integer,
    string: String,
    float: Float,
  }

  def types
    TYPES
  end

  # stub methods fot IDE

  def integer(field, **kwargs); end
  def string(field, **kwargs); end
  def float(field, exactly: false, **kwargs); end
end
