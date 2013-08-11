require 'test/unit'
require 'minitest/pride'
require_relative "../lib/flag"

class FlagTest < Test::Unit::TestCase
  def test_creates_flag
    assert Flag.new("test")
  end

  def test_check_no_bootstrap
    flag = Flag.new("--no-bootstrap")
    assert_equal :no_bootstrap, flag.check_flag
  end

  def test_raise_execption_for_invalid_flag
    flag = Flag.new("--bad-flag")
    assert_raise RuntimeError, "There is no flag, --bad-flag\nOur supported flags are currently:['--no-bootstrap']" do
      flag.check_flag
    end
  end
end