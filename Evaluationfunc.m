function fun=Evaluationfunc 
fun.fun1=@fun1;
fun.fun2=@fun2;
fun.fun3=@fun3;
fun.fun4=@fun4;
fun.fun5=@fun5;
end 
function f1=fun1(x,a) %投入型效用函数
f1=(1-exp(a.*x))./a %-x.^a
end
function f2=fun2(y,a) %收益型效用函数
f2=(1-exp(-a.*y))./a  %y.^a 
end
function f3=fun3(x,a,y) %感知函数
f3=x+1-exp(-a.*(x-y))
end
function f4=fun4(x,y,a,b)
f4=a.*(x-y).^b
end
function f5=fun5(x,y,a)
f5=(x-y).^a
end

