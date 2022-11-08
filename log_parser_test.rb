require_relative "log_parser"
require "test/unit"

class LogParserTest < Test::Unit::TestCase
  def test_finding_right_number_of_unique_entries
    ARGV.replace ["webserver_test_1.log"]

    assert_equal LogParser.new.start, "/test/1 3 unique views
/test/2 2 unique views
/test/3 1 unique view"
  end

  def test_discarding_duplicate
    ARGV.replace ["webserver_test_2.log"]

    assert_equal LogParser.new.start, "/test/1 3 unique views
/test/2 2 unique views
/test/3 1 unique view"
  end

  def test_checking_non_existing_file
    ARGV.replace ["non_existing_file"]

    assert_equal LogParser.new.start, "this is not a valid file"
  end
end
