clc;clear;

% let's simulate data
para       = [1 -1 0.5 0.95 0.95]';
[M,SIG,PI] = coefficient(para);
% length of simulated data
nT    = 200;
time  = 1:nT;
% store
Ydata = zeros(nT,1);
Sdata = zeros(nT,1);

P_cum = cumsum((PI'),1);
ns    = size(PI,1);
xit_1 = 2; %starting from the 2nd regime
Sdata(1,xit_1) = 1;

for ti=1:nT
   % generating regimes
   sdraw = rand;
   for si=1:ns
      if (sdraw<P_cum(si,xit_1))
         xit = si;
         break;
      end
   end
   
   % store regime indicator and simulated data
   Sdata(ti,xit) = 1;
   Ydata(ti,:) = M(xit) + sqrt(SIG)*randn;  
  
   % reset for the next period
   xit_1 = xit;
end

% save simulated data
save('simuldata.mat','Sdata','Ydata','para','time')

% run Hamilton filter
[neglh, probsT] = evallh_regime(para,Ydata);


% plot the simulated data
figure
subplot(2,1,1)
plot(time,Ydata,'linewidth',2)

% compare the true regime sequence and filtered regime probabilities
subplot(2,1,2)
hold on
k1=plot(time,Sdata(:,1),'linewidth',2);
k2=plot(time,probsT(:,1),'r--','linewidth',2);
kk=legend([k1,k2],'true regime sequence','filtered probability');
set(kk,'location','northoutside')
legend('boxoff')





