function [EEG_bandpassed,before,after]=denoise(data,fs)


a=snr(data,fs);
before=power(10,a/10);
%Defining the conrner frequencies
fc_low = 0.5/(fs/2);
fc_high = 30/(fs/2);
%Design Filter
[b,a] = butter(2, [fc_low fc_high]);
% Filtering
EEG_bandpassed = filter(b,a,data);
s=snr(EEG_bandpassed,fs);
after=power(10,s/10);


end