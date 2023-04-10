%绘制男女生身高的GMM
clc
clear all
num = csvread('height_data.csv');
h=num;

%画出混合后的频率分布直方图，产生150个直方图
figure(1)
hist(h,150);

%GMM的构造
%Step 1.首先根据经验来分别对男女生的均值、方差和权值进行初始化
 mu1_first=180;sigmal_first=8;w1_first=0.60;%男生的
 mu2_first=160;sigma2_first=10;w2_first=0.4;%以我们学校理工院校为例
 
 iteration=200;%设置迭代次数
 outcome=zeros(iteration,6);%定义一个数组来存储每次的迭代结果
 outcome(1,1)=mu1_first;outcome(1,4)=mu2_first;
 outcome(1,2)=sigmal_first;outcome(1,5)=sigma2_first;
 outcome(1,3)=w1_first;outcome(1,6)=w2_first;%将第一列存储初始值
% 
% %开始迭代
for i=1:iteration-1
    [mu1_last,sigma1_last,w1_last,mu2_last,sigma2_last,w2_last]=em(num,outcome(i,1),outcome(i,2),outcome(i,3),outcome(i,4),outcome(i,5),outcome(i,6));
    %将迭代结果依次送入em,更新outcome中的数值
    outcome(i+1,1)=mu1_last;outcome(i+1,2)=sigma1_last;outcome(i+1,3)=w1_last;
    outcome(i+1,4)=mu2_last;outcome(i+1,5)=sigma2_last;outcome(i+1,6)=w2_last;
end
% 
% outcome ;% 输出每次迭代结果
 figure(2);
 x1=1:0.5:iteration;
 y1=interp1(outcome(:,3),x1,'spline');  
 plot(y1,'linewidth',1.5);%画出男生的权重迭代历史
 hold on;
 grid on;
 y2=interp1(outcome(:,6),x1,'spline');
 plot(y2,'r','linewidth',1.5);%画出女生权重迭代历史
 legend('男生权重变化','女生权重变化','location','northeast');%坐标轴设置，将标识框放置在图的左上角
 title('Changes in weights of boys and girls with the number of iterations');
 xlabel('Number of iterations');
 ylabel('Weights');
 axis([1 iteration 0 1]);
% 
% %迭代的最终结果取出
mu1_last=outcome(iteration,1);
sigma1_last=outcome(iteration,2);
w1_last=outcome(iteration,3);
mu2_last=outcome(iteration,4);
sigma2_last=outcome(iteration,5);
w2_last=outcome(iteration,6);
% 
 figure(4);
 hold on;
% %男生女生以及混合后身高的概率密度曲线
 t=linspace(140,220,200);
% %女生的概率密度函数
 yy2=normpdf(t,mu2_last,sigma2_last);
 plot(t,yy2,'m','linewidth',1.5);
% %男生的概率密度函数
 yy1=normpdf(t,mu1_last,sigma1_last);
 plot(t,yy1,'linewidth',1.5);
 y3=w1_last*yy1+w2_last*yy2;
 plot(t,y3,'k','linewidth',1.5);
 legend('女生','男生','混合');
 title('男生女生以及混合后身高的概率密度曲线');
 xlabel('身高/cm');ylabel('概率');hold off;%坐标轴设置
 hold off;
















