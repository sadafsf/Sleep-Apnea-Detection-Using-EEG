function [eeg_energy,eeg_var,eeg_en,eeg_ff]=readfeatures(EEG_energy,EEG_std,EEG_entropy,EEG_ff)

% this functions reads the features for each band 
EEG_delta_energy=EEG_energy.delta;
EEG_theta_energy=EEG_energy.theta;
EEG_alpha_energy=EEG_energy.alpha;
EEG_beta_energy=EEG_energy.beta;

EEG_delta_std=EEG_std.delta;
EEG_theta_std=EEG_std.theta;
EEG_alpha_std=EEG_std.alpha;
EEG_beta_std=EEG_std.beta;

EEG_delta_entropy=EEG_entropy.delta;
EEG_theta_entropy=EEG_entropy.theta;
EEG_alpha_entropy=EEG_entropy.alpha;
EEG_beta_entropy=EEG_entropy.beta;

EEG_delta_ff=EEG_ff.delta;
EEG_theta_ff=EEG_ff.theta;
EEG_alpha_ff=EEG_ff.alpha;
EEG_beta_ff=EEG_ff.beta;

eeg_en=[EEG_alpha_entropy;EEG_beta_entropy;EEG_delta_entropy;EEG_theta_entropy];
eeg_energy=[EEG_alpha_energy;EEG_beta_energy;EEG_delta_energy;EEG_theta_energy];
eeg_var=[EEG_alpha_std;EEG_beta_std;EEG_delta_std;EEG_theta_std];
eeg_ff=[EEG_alpha_ff;EEG_beta_ff;EEG_delta_ff;EEG_theta_ff];

end