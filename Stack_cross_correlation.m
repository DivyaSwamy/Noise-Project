%INPUT
% The image file to be analyzed was already read and stored as a .mat file.

load Stacks_08_03_11_5uMegtaadded_15ms_2half.mat

% Image dimensions
my=128; mx=128;
% Number of frames that constitute a single time subsection
frames=500;
% Lag to be considered for calculation of cross correlation variable Xi 
lag=25; 
% Function section_cc_nn_Curves returns cross corelation matrix and \
% all correlation curves.

[CRM_Signal,correlation_curves]=section_cc_nn_curves(signal,frames,lag,my,mx);

