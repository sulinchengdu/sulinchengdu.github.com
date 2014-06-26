---
layout: post
category : ruby
tagline: '技术宅用代码影响着别人的生活'
tags : [intro, beginner, jekyll, tutorial]
title : 学习OpenStruct源码
---
{% include JB/setup %}

我们首先应该知道它是什么、怎样使用

<a href='http://ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html' target='_blank'>http://ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html</a> 

为了了解它是如何实现的，我们也同样创建一个类似于 OpenStruct 类的类, 命名为: OpenStruct1

第一步:

```ruby

class OpenStruct1

end

```
