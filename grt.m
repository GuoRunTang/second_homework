%������Ů����ߵ�GMM
clc
clear all
num = csvread('height_data.csv');
h=num;

%������Ϻ��Ƶ�ʷֲ�ֱ��ͼ������150��ֱ��ͼ
figure(1)
hist(h,150);

%GMM�Ĺ���
%Step 1.���ȸ��ݾ������ֱ����Ů���ľ�ֵ�������Ȩֵ���г�ʼ��
 mu1_first=180;sigmal_first=8;w1_first=0.60;%������
 mu2_first=160;sigma2_first=10;w2_first=0.4;%������ѧУ��ԺУΪ��
 
 iteration=200;%���õ�������
 outcome=zeros(iteration,6);%����һ���������洢ÿ�εĵ������
 outcome(1,1)=mu1_first;outcome(1,4)=mu2_first;
 outcome(1,2)=sigmal_first;outcome(1,5)=sigma2_first;
 outcome(1,3)=w1_first;outcome(1,6)=w2_first;%����һ�д洢��ʼֵ
% 
% %��ʼ����
for i=1:iteration-1
    [mu1_last,sigma1_last,w1_last,mu2_last,sigma2_last,w2_last]=em(num,outcome(i,1),outcome(i,2),outcome(i,3),outcome(i,4),outcome(i,5),outcome(i,6));
    %�����������������em,����outcome�е���ֵ
    outcome(i+1,1)=mu1_last;outcome(i+1,2)=sigma1_last;outcome(i+1,3)=w1_last;
    outcome(i+1,4)=mu2_last;outcome(i+1,5)=sigma2_last;outcome(i+1,6)=w2_last;
end
% 
% outcome ;% ���ÿ�ε������
 figure(2);
 x1=1:0.5:iteration;
 y1=interp1(outcome(:,3),x1,'spline');  
 plot(y1,'linewidth',1.5);%����������Ȩ�ص�����ʷ
 hold on;
 grid on;
 y2=interp1(outcome(:,6),x1,'spline');
 plot(y2,'r','linewidth',1.5);%����Ů��Ȩ�ص�����ʷ
 legend('����Ȩ�ر仯','Ů��Ȩ�ر仯','location','northeast');%���������ã�����ʶ�������ͼ�����Ͻ�
 title('Changes in weights of boys and girls with the number of iterations');
 xlabel('Number of iterations');
 ylabel('Weights');
 axis([1 iteration 0 1]);
% 
% %���������ս��ȡ��
mu1_last=outcome(iteration,1);
sigma1_last=outcome(iteration,2);
w1_last=outcome(iteration,3);
mu2_last=outcome(iteration,4);
sigma2_last=outcome(iteration,5);
w2_last=outcome(iteration,6);
% 
 figure(4);
 hold on;
% %����Ů���Լ���Ϻ���ߵĸ����ܶ�����
 t=linspace(140,220,200);
% %Ů���ĸ����ܶȺ���
 yy2=normpdf(t,mu2_last,sigma2_last);
 plot(t,yy2,'m','linewidth',1.5);
% %�����ĸ����ܶȺ���
 yy1=normpdf(t,mu1_last,sigma1_last);
 plot(t,yy1,'linewidth',1.5);
 y3=w1_last*yy1+w2_last*yy2;
 plot(t,y3,'k','linewidth',1.5);
 legend('Ů��','����','���');
 title('����Ů���Լ���Ϻ���ߵĸ����ܶ�����');
 xlabel('���/cm');ylabel('����');hold off;%����������
 hold off;
















