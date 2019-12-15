% Program calculated Power Spectra for a given image stack.
% Image will be read, spatially smoothed by takin fluorescence average over
% 3x3 camera pixel roi. Image dimensions reduce by a factor of 3.
% For each smoothed trace  power spectra is calculated.
% 
% frames = number of frames per time section
% result stored in ps(outersections,sections,factor) 
%
% ps will be used to built the power spectrum map for the stack.

clear all; close all;
%
mx=128;my=128; t=cputime;
frames=1024; tstp=0.008; % data rate 8.33 msec
outersections=10; 
sections=42*42;
intensity=zeros(outersections,sections,frames);
p1=1; ps_ol_avg=zeros(outersections,frames/2);
xx=zeros(1,outersections*frames); roi=3;
mm=zeros(1,frames);

factor=frames/2; freq=(0:factor-1)/(frames*tstp);
spread=sqrt(sections);
ps=zeros(outersections,sections,factor);

for ol=1:outersections  % ol=outerloop, looping the sections
    kk=0;   A=zeros(my,mx,frames);
x1o=1;  y1o=1;  
x1=1; y1=1;
            for i=p1:p1+frames-1
                  kk=kk+1;
    A(:,:,kk)=imread('08_03_11_5uMegtaadded_20ms_2half.tif',i);
    % Subtract black level. 
    A(:,:,kk)=A(:,:,kk)-468;
            end

for i=1:sections
    que=mod(i,spread);
   % disp('**##'),disp(i),disp(x1),disp(y1)
  
B(1:3,1:3,1:frames)=A(y1:y1+2,x1:x1+2,1:frames);

     for k2=1:frames
    mm(k2)=mean(mean(B(:,:,k2)));
     end 
     mmx=sgolayfilt(mm,3,frames-1);
     %mm_of_frames=mean(mm);
     intensity(ol,i,:)=mm;
     mm=mm-mmx;

x=abs(fft(mm))/factor;
ps(ol,i,:)=x(1:factor).^2;

clear x B mm mm_of_frames

if(gt(que,0))
x1=x1+roi;
else                
x1=x1o;
y1=y1+roi;
end

end 
ps_avg=0;

for i=1:sections
    ps_avg=ps_avg+ps(ol,i,:);
end
ps_avg=ps_avg/sections;
ps_ol_avg(ol,:)=ps_avg;
 p1=p1+frames;
 end
mps_ol_avg=mean(ps_ol_avg);

% Save the file 
save 08_03_11_5uMegtaadded_20ms_2half_Sgolayfilt_section42by42.mat
