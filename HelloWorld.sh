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

s1="Hello"
s2="World"
s3=${s1}${s2}
echo ${s1}${s2} #拼接字符串
echo "s3:${s3}"
name="zhangzhiyi"
varName1='Hello, my name is ${name}'
echo $varName1  #单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的; 单引号字串中不能出现单引号（对单引号使用转义符后也不行）
varName2="Hello, my name is ${name}"
echo $varName2  #双引号里可以有变量; 双引号里可以出现转义字符

str="This is a String" #变量重定义,第二次赋值的时候不用加美元符号，使用才加
echo ${#str}  #16 输出字符串长度
echo ${str:1:5} #his i截取字符串



