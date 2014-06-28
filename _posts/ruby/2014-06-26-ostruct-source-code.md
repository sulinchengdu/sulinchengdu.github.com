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

  def initialize(hash=nil)
    @table = {}
  end

end
```
person = OpenStruct1.new

person.name    = "John Smith"

NoMethodError: undefined method `name=' for #<OpenStruct1:0x007fc0809e0a78 @table={}>'

还记得方法查找是怎样工作的么? 当调用name()方法时, Ruby会到 person 对象的类中查询它的实例方法。如果在那里找不到 name() 方法, Ruby 会沿着祖先链向上搜寻进入Object类, 并且最终来到Kernel模块。

由于Ruby在哪里都没找到 name() 方法, 它只好承认自己的失败, 并在 person 对象(最初的接收者)上调用一个名为 method_missing() 的方法。Ruby知道总会存在一个method_missing()方法，因为它是Kernel的一个实例方法, 而所有的对象都继承自Kernel模块。

为了验证上面的理论, 我们直接调用 method_missing() 方法来进行试验, 尽管这是一个私有方法, 但是还可以通过 send() 方法来做到:

person.send :method_missing, :name

=> NoMethodError: undefined method `name=' for #<OpenStruct1:0x007fc0809e0a78 @table={}>'

以上正好做了Ruby解释器所做的工作。我们告诉 person 这个对象说, "我试着调用你一个名为 name()的方法, 但是你不明白我想干什么。" Kernel#method_missing()方法会抛出一个NoMethodError进行响应，这是它全部的工作。它就像对象的失物招领处，所有无法投递的消息最后都会来到这里。

覆写method_missing()方法(Overriding method_missing())

我们几乎不可能亲自调用 method_missing() 方法。不过, 你可以通过覆写它来截获无主的消息。每一个来到 method_missing()办公桌上的消息都带着被调用方法的名字, 以及所有调用时传递的参数与块。

def method_missing(method, *args) # :nodoc:
  p method
  p *args 
end


