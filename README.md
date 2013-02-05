
# usage

ruby script.rb inputfile

# why

输入是html文件。内容有英文有中文。输出必须是英文和中文的unicode编码，加上&#前缀和;后缀。

这样，文件里面的所有字符都是ascii字符，且浏览器可以把中文字形显示出来。

为什么需要这样转换我不记得了。但这是需求。

因此我写了这个脚本。

# TODO

其实我不知道如何递归处理html的嵌套标签。

我使用hpricot看到了 traverse_all_element 这个方法，但不知道怎么用。

我的需求是

输入

<p>some words <span> 中文 english </span> 中国 </p>

我希望在处理p的时候，能暂时不处理嵌套的span，转换p的其它内容，然后再处理span。

如果我直接去处理 p.inner_html 会把错的，因为它返回的是一个hpricot的对象，不是字符串！

请高手指教。

我准备看看nokogiri。虽然它看起来特别负载。
