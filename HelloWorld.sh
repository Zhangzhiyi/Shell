#!/bin/sh
str="HelloWorld" #等号两边不能有空格存在
echo $str
apple="iphone"
echo "I have a $apple_ok"	#打印 I have a
echo "I have a ${apple}_ok"	#打印 I have a iphone_ok
#shell的默认赋值是字符串赋值
_int=1
_sum=$_int+1
echo $_sum	#打印1+1
# $[]   表示将中括号内的表达式作为数学运算先计算结果再输出
_sum=$[$_int+1]
echo $_sum	#打印2
