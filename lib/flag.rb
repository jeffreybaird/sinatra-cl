class Flag
  attr_reader :flag_name

  def initialize(flag_name)
    @flag_name = flag_name
  end

  def check_flag
    self.send(flag_name.match(/\A(--)(\S*)/).to_a.last.gsub("-","_").to_sym)
  end

  private

  def method_missing(meth, *args, &block)
    raise "There is no flag, #{flag_name}\nOur supported flags are currently:#{supported_flags}"
  end

  def supported_flags
    ["--no-bootstrap"]
  end

  def no_bootstrap
    :no_bootstrap
  end

end