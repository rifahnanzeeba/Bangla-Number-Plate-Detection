clc
close all;
clear;
load imgfildata;
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
im_input=imread(s);
%im_input = imread(uigetfile('.png'));
imgray = rgb2gray(im_input);
imbin = imbinarize(imgray);
picture = edge(imgray, 'prewitt');


%Below steps are to find location of number plate
Iprops=regionprops(picture,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

picture = imcrop(imbin, boundingBox);%crop the number plate area
picture = bwareaopen(~picture, 50); %remove some object if it width is too long or too small than 500

 [h, w] = size(picture);%get width
imshow(im_input);
figure
imshow(picture);


%%

% [file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
% s=[path,file];
% picture=imread(s);
% [~,cc]=size(picture);
% picture=imresize(picture,[300 500]);
% 
% if size(picture,3)==3
%   picture=rgb2gray(picture);
% end
% 
% threshold = graythresh(picture);
% picture =~imbinarize(picture,threshold);
% picture = bwareaopen(picture,30);
imshow(picture)
if w>2000
    picture1=bwareaopen(picture,3500);
else
picture1=bwareaopen(picture,3000);
end
figure,imshow(picture1)
picture2=picture-picture1;
figure,imshow(picture2)
picture2=bwareaopen(picture,200);
figure,imshow(picture2)

[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
pause(1)
for n=1:size(propied,1)
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

figure
final_output=[]; %preallocating
t=[];
for n=1:Ne
  [r,c] = find(L==n);
  n1=picture(min(r):max(r),min(c):max(c));
  n1=imresize(n1,[42,24]);
  imshow(n1)
  pause(0.2)
  x=[ ];

totalLetters=size(imgfile,2);

 for k=1:totalLetters
    
    y=corr2(imgfile{1,k},n1);
    x=[x y];
    
 end
 t=[t max(x)];
 if max(x)>.40
 z=find(x==max(x));
 out=cell2mat(imgfile(2,z));

final_output=[final_output out];
end
end
% [final_L, final_N]=Separator(final_output)
% % s = 'x 5.67 y 7.789'
d=cell2mat(extract(final_output,'d'));
m=cell2mat(extract(final_output,'m'));
g=cell2mat(extract(final_output,'g'));
k=cell2mat(extract(final_output,'k'));
numbers=cell2mat(regexp(final_output,'[\d.]+','match'));
final=[ d m g k numbers];
%numbers = str2double(extract(final_output, digitsPattern))
file = fopen('number_Plate.txt', 'wt');
    fprintf(file,'%s\n',final);
    fclose(file);                     
    winopen('number_Plate.txt')