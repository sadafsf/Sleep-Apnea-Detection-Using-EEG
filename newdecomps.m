function [EEG_bands,EEG_entropy,EEG_std, EEG_energy,EEG_FF]=newdecomps(EEG_bandpassed,fs,t)
% In this fucntion, we will be defining the bands within the signal
%Useful Frequency Range is Alpha: 8-13 Hz, Beta: 13-22Hz, Delta: 0.5-4 Hz, Theta: 4-8 Hz

% Alpha: 8-13 Hz
[zA,pA,kA] = butter(6,[8 13]/fs,'bandpass');
[aA,bA] = zp2sos(zA,pA,kA);
falpha= dfilt.df2sos(aA,bA);

% Beta: 13-22Hz
[zB,pB,kB] = butter(6,[13 22]/fs,'bandpass');
[aB,bB] = zp2sos(zB,pB,kB);
fbeta= dfilt.df2sos(aB,bB);

% Delta: 0.5-4 Hz
[zD,pD,kD] = butter(6,[0.5 4]/fs,'bandpass');
[aD,bD] = zp2sos(zD,pD,kD);
fdelta= dfilt.df2sos(aD,bD);

% Theta: 4-8 Hz
[zT,pT,kT] = butter(6,[4 8]/fs,'bandpass');
[aT,bT] = zp2sos(zT,pT,kT);
ftheta= dfilt.df2sos(aT,bT);


fA=falpha;
fB=fbeta;
fD=fdelta;
fT=ftheta;

Data = EEG_bandpassed;

%Filtration 
DataFilterA=filter(fA,Data);
DataFilterB=filter(fB,Data);
DataFilterD=filter(fD,Data);
DataFilterT=filter(fT,Data);

%plots
% figure;
% hold on;
% subplot(4,1,1);
% plot(t,DataFilterA,'-r');% Plotting Alpha Wave
% xlabel('Time(sec)');
% ylabel('μV');
% title('Alpha Wave');
% grid;
% subplot(4,1,2);
% plot(t,DataFilterB,'-b');% Plotting Beta Wave
% xlabel('Time(sec)');
% ylabel('μV');
% title('Beta Wave');
% grid;
% subplot(4,1,3);
% plot(t,DataFilterD,'-g');% Plotting Delta Wave
% xlabel('Time(sec)');
% ylabel('μV');
% title('Delta Wave');
% grid;
% subplot(4,1,4);
% plot(t,DataFilterT,'-k');% Plotting Theta Wave
% xlabel('Time(sec)');
% ylabel('μV');
% title('Theta Wave');
% grid;


EEG_bands=struct('alpha',DataFilterA,'beta',DataFilterB,'delta',DataFilterD,'theta',DataFilterT);

EntropyA = entropy(DataFilterA);
EntropyB= entropy(DataFilterB);
EntropyD= entropy(DataFilterD);
EntropyT= entropy(DataFilterT);


EEG_entropy=struct('alpha',EntropyA,'beta',EntropyB,'delta',EntropyD,'theta',EntropyT);

stdA= var(DataFilterA);
stdB= var(DataFilterB);
stdD= var(DataFilterD);
stdT= var(DataFilterT);


EEG_std=struct('alpha',stdA,'beta',stdB,'delta',stdD,'theta',stdT);

for i=1:7500
energyA=sum(abs(DataFilterA(i,1)));
energyB=sum(abs(DataFilterB(i,1)));
energyD=sum(abs(DataFilterD(i,1)));
energyT=sum(abs(DataFilterT(i,1)));
end

EEG_energy=struct('alpha',energyA,'beta',energyB,'delta',energyD,'theta',energyT);
Mx_Alpha = (var(diff(DataFilterA))/stdA);
Mx_Beta = (var(diff(DataFilterB))/stdB);
Mx_Delta = (var(diff(DataFilterD))/stdD);
Mx_Theta = (var(diff(DataFilterT))/stdT);


%now calcualte the form factor FF = Mx'/Mx
m1=var(diff(diff(DataFilterA)))/var(diff(DataFilterA));
m2=var(diff(diff(DataFilterB)))/var(diff(DataFilterB));
m3=var(diff(diff(DataFilterD)))/var(diff(DataFilterD));
m4=var(diff(diff(DataFilterT)))/var(diff(DataFilterT));

FF_Alpha = (m1/Mx_Alpha);
FF_Beta = (m2/Mx_Beta);
FF_Delta = (m3/Mx_Delta);
FF_Theta = (m4/Mx_Theta);


EEG_FF = struct('alpha',FF_Alpha,'beta',FF_Beta,'delta',FF_Delta,'theta',FF_Theta);

end