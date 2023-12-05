clear
X=[0.235462	0.269169	3.204789	0.06502	0.319508	0.27314	0.136364	0.029279	0.034105	0.307811	0.004136	0.015273
0.24671585	0.26283475	2.34806246	0.01978341	0.09719265	0.13556257	0.05827393	0.01982201	0.02221817	0.19939624	0.00156883	0.00802825];
Y=[3.1243	2.3884	27.12	0.1365	0.7842	0.8586	0.6432	0.1489	0.1629	1.7326	0.0319	0.0671
2.48753735	1.60579749	23.35838332	0.3218403	2.91567328	1.4921045	0.38623482	0.15553078	0.16994108	1.80680552	0.0097464	0.04909143];
n=size(X',1);m=size(X,1);s=size(Y,1);
idx=min(X')';idy=max(Y')'; %理想点,单点
aidx=max(X')';aidy=min(Y')'; %非理想点，单点
avx=geomean(X',1)';avy=geomean(Y',1)'; %内点，单点
fun=Evaluationfunc; %调用，计算效用和感知效用
%davx=X-avx; %均值差值
%davy=Y-avy;
%daidx=X-aidx;%非理想点差值
%daidy=Y-aidy;
%didx=X-idx; %理想点差值
%didy=Y-idy;
a=0.02;
b=2.5;
uavx=fun.fun3(fun.fun1(X,a),b,fun.fun1(avx,a)); %均值感知效用，I
uavy=fun.fun3(fun.fun2(Y,a),b,fun.fun2(avy,a));
uidx=fun.fun3(fun.fun1(X,a),b,fun.fun1(idx,a)); %理想点效用，G
uidy=fun.fun3(fun.fun2(Y,a),b,fun.fun2(idy,a));
uaidx=fun.fun3(fun.fun1(X,a),b,fun.fun1(aidx,a)); %非理想点效用，L
uaidy=fun.fun3(fun.fun2(Y,a),b,fun.fun2(aidy,a));

%uavx
%uidx
%uaidx
%uavy
%uidy
%uaidy
c=0.5;d=0.5;
for i=1:n
    f=-[zeros(1,m) Y(:,i)'];
    A=[-X' Y']; b=zeros(n,1);
    lb=zeros(m+s,1);ub=[];
    Aeq=[X(:,i)' zeros(1,s)];beq=1;
    [w(i,:),fval(1,i)]=linprog(f,A,b,Aeq,beq,lb,ub); %权重和自评效率
    eii=w(i,m+1:m+s)*Y(:,i);
    for k=1:n 
        f=-[c.*uavx(:,k)'+(1-c).*(1-d).*uidx(:,k)'+(1-c).*d.*uaidx(:,k)' c.*uavy(:,k)'+(1-c).*(1-d).*uidy(:,k)'+(1-c).*d.*uaidy(:,k)']; %第二目标函数，决策变量的系数要合并
        %f=-[-0.1.*uidx(:,k)'+0.9.*uaidx(:,k)' -0.1.*uidy(:,k)'+0.9.*uaidy(:,k)']
        Aeq=[X(:,i)' zeros(1,s);
             eii*X(:,i)' -Y(:,i)'];
         beq=[1;0];
         lb=zeros(m+s,1);ub=[];
         v=linprog(f,A,b,Aeq,beq,lb,ub);
         e(k,i)=(Y(:,k)'*v(m+1:m+s))./(X(:,k)'*v(1:m));
         
    end
   %v 
end
e
se=sum(e,1);
E=e./se;
%EE=-E.*log(E)./((exp(0.5)-1)*n); 灰色熵值
t=1.5;q=2;
E1=sum(E.*(t.^(log(1./E))./log(q)),1);
E2=log(E1)./log(t);
ee=(1-sum(E2,1))./(n-sum(sum(E2,1)));

xita=sum(ee.*e,2);
xita    


 
