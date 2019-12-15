function [cross_correlation_values,mean_crosscorrelation_value]=Calculate_RC_LengthScale_Sgolayfilt(tr,frames,lag)
% INPUT: trace- time series matrix for which crosscorrelations are
% caluclated, each pixel cross correlated with only ring neighbors.
%        frames- measure of time subsections. 
%        lag- sum to lag.
% OUTPUT: cross_correlation_values = array of cc values for trace
%         mean_crosscorrelation_value = mean of cross_correlation_values


os = size(tr,3)./frames; os =floor(os);
cross_correlation_values=zeros(os,1); 
index=frames:frames+lag-1;
index2=frames:frames+2*lag-1;


p1=1; num_pixels= size(tr,1)*size(tr,2);

 for loop = 1:os
     Mat = tr(:,:,p1:p1+frames-1);
     count=0; ff=zeros(num_pixels,frames); count2=0;
     z=zeros(num_pixels-1,2*frames-1); Brdy=[];
     center_point=ceil(num_pixels/2);
         for jk = 1:size(Mat,1)
         for ik = 1:size(Mat,2)
              count=count+1; 
              %%%%%
              % Apply SGOLAYFILT to correct
              proxy(1,:)= Mat(jk,ik,:);
              mmx = sgolayfilt(proxy,3,frames-1);
              ff(count,:)=proxy-mmx;
              %%%%%%
              if ik==1
                  Brdy = cat(1,Brdy,count);
              elseif ik==size(Mat,2)
                  Brdy = cat(1,Brdy,count);
              elseif jk==1 && ik >1 && ik < size(Mat,2)
                  Brdy = cat(1,Brdy,count);
              elseif jk==size(Mat,1) && ik > 1 && ik< size(Mat,2)
                   Brdy = cat(1,Brdy,count);
              end
         end
         end
         cpx=ff(center_point,:);
         for kk=1:length(Brdy)
          %   if (kk~=center_point)
                 count2=count2+1;
                 z(count2,:)=xcorr(cpx,ff(Brdy(kk),:),'coeff');
          %   end
         end
         proxy25=sum(sum(z(1:count2,index),1)); proxy25 = proxy25./count2;
         proxy50=sum(sum(z(1:count2,index2),1)); proxy50 = proxy50./count2;
         cross_correlation_values(loop,1)= 2*proxy25-proxy50;
         p1 = p1+frames;
        % disp(p1)
 end
             
     mean_crosscorrelation_value = mean(cross_correlation_values);
end

