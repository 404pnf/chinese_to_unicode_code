# -*- coding: utf-8 -*-
require 'test/unit'
require_relative 'chinese_to_unicode'



class TestZhToUnicode < Test::Unit::TestCase
  #>> '中'.codepoints.first
  #=> 20013
  INPUT = File.read('test/input.html')
  o = '''
<p>zhognwen&#20013;&#25991;</p>
<div>&#20013;&#22269;zhongguo<span>&#20013;&#24335;zhongshi</span></div>
'''
  OUTPUT = o.lstrip
  def test_mixed_str_to_unicode!
    assert_equal '&#20013;', mixed_str_to_unicode!('中'), '只有中文'
    assert_equal 'abc&#20013;', mixed_str_to_unicode!('abc中'), '中文和英文混合'
    assert_equal OUTPUT, mixed_str_to_unicode!(INPUT), '含有html标签的文本'
  end
end
