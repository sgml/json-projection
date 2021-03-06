require_relative 'test_helper'

class ObjectStructure < JsonParserTest
  def test_simple_key_value_pair
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      String.new("bar"),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\":\"bar\"}")
  end

  def test_key_value_pair_with_whitespace
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      String.new("bar"),
      EndObject.empty,
      EndDocument.empty
    ], events("{ \"foo\" : \"bar\" }")
  end

  def test_multiple_key_value_pairs
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      String.new("bar"),
      Key.new("qux"),
      String.new("quux"),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": \"bar\", \"qux\": \"quux\"}")
  end

  def test_true_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Boolean.new(true),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": true}")
  end

  def test_false_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Boolean.new(false),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": false}")
  end

  def test_null_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Null.empty,
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": null}")
  end

  def test_integer_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Number.new(100),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": 100}")
  end

  def test_negative_number_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Number.new(-100),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": -100}")
  end

  def test_float_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Number.new(0.1),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": 0.1}")
  end

  def test_exponent_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      Number.new(100),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": 10e+1}")
  end

  def test_nested_object_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      StartObject.empty,
      Key.new("bar"),
      Number.new(100),
      EndObject.empty,
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": {\"bar\": 100}}")
  end

  def test_nested_array_value
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      StartArray.empty,
      String.new("bar"),
      Number.new(100),
      EndArray.empty,
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": [\"bar\", 100]}")
  end

  def test_duplicate_keys
    assert_equal [
      StartDocument.empty,
      StartObject.empty,
      Key.new("foo"),
      String.new("bar"),
      Key.new("foo"),
      String.new("baz"),
      EndObject.empty,
      EndDocument.empty
    ], events("{\"foo\": \"bar\", \"foo\": \"baz\"}")
  end
end
