class OpenStruct1

  def initialize(hash=nil)
    @table = {}
  end

  def method_missing(method, *args) # :nodoc:
    p method
    p *args
  end

end
