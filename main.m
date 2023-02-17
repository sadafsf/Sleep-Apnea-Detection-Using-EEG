%% Load the CSV file 
apnea_data=readtable("/Users/sadafsafa/Desktop/new_apnea.csv"); 
normal_data=readtable("/Users/sadafsafa/Desktop/normal_normal.csv");

%% filter signals and plot a sample of normal and apnea signal 

% in total 20 apnea signal, 20 normal signal
apnea=apnea_data.Variables;
normal=normal_data.Variables;

f1=250; %sampling freq
f2=100;

t=[0:7500-1]/f1;
len=7500; %lenght of signal 
eeg_normal_filtered =zeros;
eeg_apnea_filtered=zeros;

% plot a sample of the normal and apnea signal 
subplot(211);
plot(t,apnea(:,3))
xlabel("Time(s)");
ylabel("Amplitude (μV)");
title("Apnea Signal");
subplot(212);
plot(t,normal(:,3));
xlabel("Time(s)");
ylabel("Amplitude (μV)");
title("Normal Signal");

% use the function denoise to filter the signal and fins the SNR before and
% after filtartion

snr_apnea_before=0;
snr_normal_before=0;
snr_apnea_after=0;
snr_normal_after=0;

for i=1:20
    [a,snr_apnea_before,snr_apnea_after]=denoise(apnea(:,i),f1);
    snr_apnea_before(1,i)=snr_apnea_before; % stores value of SNR before the filtarion 
    snr_apnea_after(1,i)=snr_apnea_after; % stores value of SNR after filtartion 
    for j=1:len
        eeg_apnea_filtered(j,i)=a(j,1); % stores filtred apnea signal 
    end 
end

for i=1:20 
     [n,snr_normal_before,snr_normal_after]=denoise(normal(:,i),f2);
     snr_normal_before(1,i)=snr_normal_before; %stores value of SNR before the filtration 
     snr_normal_after(1,i)=snr_normal_after; %stores value of SNR after filtartion 
     for j=1:len
        eeg_normal_filtered (j,i)=n(j,1); % stores filtred normal signal 
     end 
end

%%
%finding the average SNR for apnea and normal signals before and after filtering part
snr_apnea_before_avrg=mean(snr_apnea_before)
snr_normal_before_avrg=mean(snr_normal_before)
snr_apnea_after_avrg=mean(snr_apnea_after)
snr_normal_after_avrg=mean(snr_normal_after)

% sample plot of apnea signal before and after filtering part
figure;
subplot(211);
plot(t,apnea(:,1));
subplot(212);
plot(t,eeg_apnea_filtered(:,1));

%% sub-band separation and feature extraction 

apnea_energy=0; apnea_var=0; apnea_entropy=0; apnea_formfactor=0;
normal_energy=0; normal_var=0; normal_entropy=0; normal_formfactor=0;

for i=1:20
    %this for loop extract energy, entopy, form factor and variance from
    %each sub band: theta,delta,alpha,beta
    [a_band,a_en,a_std,a_energy,a_ff]=newdecomps(eeg_apnea_filtered(:,i),f1,t);
    [n_band,n_en,n_std,n_energy,n_ff]=newdecomps(eeg_normal_filtered (:,i),f2,t);
    
    for j=1:4
        %the function readfeatures will read the features for each subband of one signal  
        [val_energy_A,val_var_A,val_en_A,val_ff_A]=readfeatures(a_energy,a_std,a_en,a_ff);
        [val_energy_N,val_var_N,val_en_N,val_ff_N]=readfeatures(n_energy,n_std,n_en,n_ff);
        
        % stores value of the features from each sub band of a signal
        apnea_energy(j,i)=val_energy_A(j,1);
        apnea_var(j,i)=val_var_A(j,1);
        apnea_entropy(j,i)=val_en_A(j,1);
        apnea_formfactor(j,i)=val_ff_A(j,1);
    
        normal_energy(j,i)=val_energy_N(j,1);
        normal_var(j,i)=val_var_N(j,1);
        normal_entropy(j,i)=val_en_N(j,1);
        normal_formfactor(j,i)=val_ff_N(j,1);
     end

end

%% construct dataset
% for the naming, 
% 1= apnea
% 2= normal 
% in total, 80 values for each feature of normal and apnea signal
energy1=apnea_energy(:);
entropy1=apnea_entropy(:);
vari1=apnea_var(:);
energy2=normal_energy(:);
entropy2=normal_entropy(:);
vari2=normal_var(:);
form1=apnea_formfactor(:);
form2=normal_formfactor(:);

%% construct a table for the features 

energy=[energy1;energy2];
variance=[vari1;vari2];
entropy=[entropy1;entropy2];
formfactor=[form1;form2];
out=[ones(80,1);zeros(80,1)]; % one hot encode the ourput, 0 for normal and 1 for apnea
f=[energy,variance,entropy,formfactor,out];
features=array2table(f,'VariableNames',{'Energy','Variance','Entropy','Form Factor','Ouput'});

%% write the table into csv file 
writetable(features,'/Users/sadafsafa/Desktop/final1.csv'); 


