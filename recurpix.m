%%% This function works just like the last part of my previous function,
%%% except calling a recursion in case of boundary pixel that has more then two neighbors.  

%%% notations:
%%% x <-- massive that has ones for points of the background and zeros for points of the objects' boundaries;
%%% y <-- massive of colored contours;
%%% z <-- color, choosed randomly;
%%% u <-- row's number;
%%% v <-- colomn's number.
%
 function [x,y] = recurpix (x,y,z,u,v);       %%% starts function definition
 x(u,v)=1;                                    %%% at the first step it delets pixel from massive x of ones and zeros
 y(u,v,:)=z;                                  %%% colors pixel with the same coordinates, but in the colored massive y
  while ((x(u,v+1)+x(u+1,v)+x(u+1,v+1)+x(u-1,v-1)+x(u,v-1)+x(u-1,v+1)+x(u+1,v-1)+x(u-1,v)) == 7)     
  %%%% as every point of boundary in massive x is equal to zero, checks the sum of neighbors. It should be 7 for pixel with only one neighbor.
           x(u,v)=1;                            %%% delets point
          if x(u,v+1)==0;
            v=v+1;
            y(u,v,:)=z;
          elseif x(u+1,v)==0;                                          
            u=u+1;                                                  
            y(u,v,:)=z;                                   %%% All the if/elseif check one of 8 points around x(u,v),
          elseif x(u+1,v+1)==0;                            %%% if it belongs to contour,
            u=u+1;                                          %%% it changes position to it in x and colors this next point in y
            v=v+1;
            y(u,v,:)=z;
          elseif x(u-1,v-1)==0;
            u=u-1;
            v=v-1;
            y(u,v,:)=z;
          elseif x(u,v-1)==0;
            v=v-1;
            y(u,v,:)=z;
          elseif x(u-1,v+1)==0;
            u=u-1;
            v=v+1;
            y(u,v,:)=z;
          elseif x(u+1,v-1)==0;
            u=u+1;
            v=v-1;
            y(u,v,:)=z;
          elseif x(u-1,v)==0;
            u=u-1;
            y(u,v,:)=z;
          end
     endwhile;
 x(u,v)=1;                                              %%%% and the last point with no more neighbors should be deleted
 y(u,v,:)=z;                                            %%%%...and colored in massive y 
      
            if x(u,v+1)==0;
            [x,y] = recurpix(x,y,z,u,v+1);
            end;
            if x(u,v-1)==0;
            [x,y] = recurpix(x,y,z,u,v-1);                         %%% here it checks if the previous cycle was broken due to more than one neighbor contour pixel
             end;                                                  %%% for each such a pixel the function is called recursively
            if x(u+1,v)==0;
            [x,y] = recurpix(x,y,z,u+1,v);
             end;
            if x(u+1,v-1)==0;
            [x,y] = recurpix(x,y,z,u+1,v-1);
             end;
            if x(u+1,v+1)==0;
            [x,y] = recurpix(x,y,z,u+1,v+1);
             end;
            if x(u-1,v+1)==0;
            [x,y] = recurpix(x,y,z,u-1,v+1);
             end;
            if x(u-1,v)==0;
            [x,y] = recurpix(x,y,z,u-1,v);
             end;
            if x(u-1,v-1)==0;
            [x,y] = recurpix(x,y,z,u-1,v-1);
           end;
          
                 
 endfunction
   
     