
# Noise Project

Repository with codes used to calculate power spectra and correlation maps 
presented in the paper **_Noise analysis of cytosolic calcium image data_** .

These codes are presented as a guide(to illustrate how power spectra 
and correlations were calculated) for the interested reader to develope their own codes for analysis.

You may use them as is but based on the needs and parameters of individual experiments they most 
likely will need to be revised. 

###  (1) power_spectra_stack.m
 This file takes in an image stack and calculates the power spectra after spatial smoothing. The output **ps** 
 is a 3D matrix which stores power spectra for the entire stack.
 
### (2) Calculate_PSM_stack.m
Using matrix ps, this file constructs power spectral maps as shown in Fig.3 of the manuscript.

### (3) Stack_cross_correlation.m
File that calls function section_cc_nn_curves.m to calculate correlations for an image stack.

### (4) section_cc_nn_curves.m
Function that takes in a stack, subsections it in time and calculated the cross correlation  per pixel. 
Output is the cross correlation matrix and correlation curves per pixel.

### (5) Calculate_RC_LengthScale_Sgolayfilt.m
Function that calculates ring cross correlations (Fig 6)


