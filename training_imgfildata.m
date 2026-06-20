clc;           
clear;        
close all;  
di=dir('BanglaAlpha');
st={di.name};
nam=st(3:end);
imgfile=cell(2,length(nam));
for i=1:length(nam)
   imgfile(1,i)={imread(['BanglaAlpha','\',cell2mat(nam(i))])};
   temp=cell2mat(nam(i));
   imgfile(2,i)={temp(1)};
end
save('imgfildata.mat','imgfile');
clear;
