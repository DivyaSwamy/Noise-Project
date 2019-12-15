function[RatioMat_PS]=Calculate_PSM_stack(ps,split,freq1,freq2,freq3,freq4,sections,spread)
    %INPUT
    % ps = power spectrum  for images stack
    %in dimensions ( num of timesubsections/ outersections, sections,factor)
    % from  ps we build the PSM. 
    % freq1-4 represent the low and high frequency range.
    % sections  = reduced dimensions of the image
    % spread = sqrt(sections)
    % split = timesubsection where the IP3 flash is present
    % all subsections before split constitute the  baseline PSM
    % all subsections after split consitude the signal PSM.

    dimx=42; dimy=42; dimz=size(ps,1)-split;
    
    RatioMat_PS=zeros(dimx,dimy,dimz);
    
    for jk=1:dimz
        val1=mean(ps(split+jk,:,freq1:freq2),3);
        val2=mean(ps(split+jk,:,freq3:freq4),3);
        %
        val_segment=(val1-val2)./(val2); % eta value for the coordinate. 
        xcor=1; ycor=1;
        %
        for i=1:sections
            pointer=mod(i,spread);
            RatioMat_PS(ycor,xcor,jk)=val_segment(i);
                if(gt(pointer,0))
                xcor=xcor+1;
                else
                ycor=ycor+1;
                xcor=1;
                end
        end        
    end  
   
end
% Calculated for file: 08_03_11_5uMegtaadded_20ms_2half_Sgolayfilt_section42by42.mat  