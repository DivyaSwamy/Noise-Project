function[correlation_matrix, correlation_curves]=section_cc_nn_curves(stack,lag,frames)
%
% Edited March1 2018 @ DS
% Take a stack, section it in time, compute nearest neighbours cross
% correlation. detrend the frames length time series and then calculate 
% corelations summed to 25 lags. Save all correlation curves. 
%
% INPUT 
% stack = 3D image stack (x,y,t)
% lag = lags over which we will sum up  the cross correlation 
% curves. 
% frames = number of frames in a given timesubsection
% OUTPUT
% correlation_matrix = calculated cross correlation matrix
% with dimensions(x,y, timesubsections)
% timesubsections = t/frames
%
% 
outersections=floor(size(stack,3)/frames);
my=size(stack,1); mx=size(stack,2);
correlation_matrix=zeros(my,mx,outersections);
correlation_curves= zeros(my,mx,outersections,frames);

index=frames:frames+lag-1;
index2=frames:frames+2*lag-1;

    p1=1; 
    for ol=1:outersections  % ol=outerloop, looping the sections
        %
        A=zeros(my,mx,frames);
        A(1:my,1:mx,1:frames)=stack(1:my,1:mx,p1:p1+frames-1);
        % 
            for j=2:my-1
                for i=2:mx-1
                count=0; count2=0; ff=zeros(9,frames); z=zeros(8,2*frames-1);
                for k1=-1:1
                     for k2=-1:1
                     count=count+1;
                     mm=sgolayfilt(A(j+k1,i+k2,:),3,frames-1);        
                     ff(count,:)=A(j+k1,i+k2,:)-mm;
                     end
                end
                % center pixel
                cpx=ff(5,:);
         
                for kk=1:count
                    if(kk ~=5)
                    count2=count2+1;
                    npx=ff(kk,:);  
                    z(count2,:)=xcorr(cpx,npx,'coeff');
                    end
                end
                correlation_curves(j,i,ol,:)= mean(z(:,frames:end),1);
                proxy25=sum(sum(z(1:count2,index),1)); proxy25 = proxy25./count2;
                proxy50=sum(sum(z(1:count2,index2),1)); proxy50 = proxy50./count2;
                correlation_matrix(j,i,ol)= 2*proxy25-proxy50;       
     
        clear z ff proxy
                end   
            end

    p1=p1+frames;
    disp(p1)
     end  % end outersection loop

return
end


