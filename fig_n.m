   

function clea=fig_n(a)
%
%This function takes a picture a='name.extension' as an argument and returns a figure of external boundaries of objects
%placed on picture all colored differently (on the white background)if the background of the given picture is uniform 
%and all objects don't touch the borders of the picture. 
%
b=imread(a); %Function imread returns the matrix of three dimentions (number of pixels in length, number of pixels in hight, rgb - 3 numbers )
k=size(b);  %gives the matrix=[length hight 3]

b1=b(1,1,:); %left upper corner, gives rgb combination for background

c=[];  %prepares an empty massive for matrix(length, hight) with 0 for background coordinates and 1 for objects' pixels
for i=1:1:k(1,1);  %goes through raws from the first to the last
  for j=1:1:k(1,2); %and columns
    if b(i,j,:)==b1;             
      c(i,j)=0;             %changes all background's rgb-vectors to 0 
    else
      c(i,j)=1;              % changes objects' rgb-vectors to 1 
    end
  end
end



%starting from here prepares a massive l (<--it is small letter L) for object contours (not colored). Points of boundaries will be equal to 0,
%all the others to 1.
l=[];
l(size(c)(1,1),size(c)(1,2))=1; %violently makes right lower corner equal to 1, i.e.it is background.
l(1,size(c)(1,2))=1;% the same with right upper
l(size(c)(1,1),1)=1;%...and left lower
l(1,1)=1;% and left upper

for i=2:1:(size(c)(1,1)-1); %goes through raws
  l(i,1)=1;              %makes first raw to be a background
  l(i,size(c)(1,2))=1; %and the last
  for j=2:1:(size(c)(1,2)-1);%through columns
      l(1,j)=1;              %makes the first column to be a background
      l(size(c)(1,1),j)=1;     %and the last
      if ((c(i,j)==0) && (c(i,j+1)==1)) || ((c(i,j)==0) && (c(i,j-1)==1)) || ((c(i,j)==0) && (c(i+1,j)==1)) || ((c(i,j)==0) && (c(i-1,j)==1));% if at least one of the 
      l(i,j)=0;                              %neighbor-pixels for 0-pixel of massive l (<--small L again) is 1 it stays 0 (as it was)
          else
      l(i,j)=1;                               %if not turns into 1
      end                                     
      
  end
 
end                       % now we have all contours marked as 0 in matrix l


p=ones(size(l)(1,1),size(l)(1,2),3).*255; %creates massive to be transformed into picture with rgb-colors. At this step it is a white empty picture

p1=size(p)(1,1); %length of future picture
p2=size(p)(1,2);%its height
  
for i=2:1:(size(l)(1,1)-1);    %goes through lines
  for j=2:1:(size(l)(1,2)-1);    % through columns
    if l(i,j)==0;               % point belongs to the objects' contour
        d=[rand(max(p1,p2),max(p1,p2),255)(i,j) rand(max(p1,p2),max(p1,p2),255)(1,i) rand(max(p1,p2),max(p1,p2),255)(j,i)];%randomly chooses color  
       [l,p] = recurpix (l,p,d,i,j);  %%% calls a function (with full description in file named recurpix.m) 
                                                      
            
     end
    
     end
    
     end
 

 clea = imshow(p);                             %returns a picture of an object
 
end