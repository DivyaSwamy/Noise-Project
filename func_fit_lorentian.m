function [fobj,gof,yy2] =func_fit_lorentian(trace,freq_lim1,freq_lim2,freq)
% July 9 2014 // DS
% this function takes in a trace and calculates the approximate Lorentian

if isrow(trace)==0
    trace=trace';
end

if isrow(freq)==0
    freq=freq';
end


index=find(freq>freq_lim1 & freq<=freq_lim2);
xx=freq(index); yy=trace(index); yy=smooth(yy,3);
% Yr smoothing window should frequency dependent. 
% xx1=freq(index1); yy1=trace(index1); yy1=smooth(yy1,9);

% Start fitting
s=fitoptions('Method','NonlinearLeastSquares','Lower',[0 0]);
% general model to fit: Lorentian
gm1=fittype('a/(1+(x/b).^2)','options',s); % general model 1
% gm2=fittype('c*x','options',s); % general model 2
% xx=xx';

[fobj,gof] = fit(xx',yy,gm1);

%{
denominator=(1+(xx./fobj.b).^2);
yy2=(fobj.a)./denominator;
figure
loglog(freq,smooth(trace,5),'-*')
hold on
loglog(xx,yy2,'r--','LineWidth',2.0)
%}

denominator=(1+(freq./fobj.b).^2);
yy2=(fobj.a)./denominator;

cmap=rand(1,3);

i=floor(100*rand);
figure(i)
loglog(freq,smooth(trace,5),'-*','Color',cmap)
hold on
loglog(freq,yy2,'r--','LineWidth',2.0)


end

