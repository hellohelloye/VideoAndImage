function [ finalmatrix ] = hysteresisThresh( aftNmsuppress,eo,highThresh,lowThresh,originalImage)
es=aftNmsuppress;
[x_size,y_size]= size(originalImage)
for x=1:x_size
    for y=1:y_size
        if((es(x,y) > highThresh)&&es(x,y)~=255)
            es(x,y)=255;
           if(eo(x,y) == 0)
               if(es(x+1,y) < lowThresh)
                     es(x+1,y)=0;
               elseif(es(x+1,y)> lowThresh)
                     es(x+1,y)=255;
               end
               if(es(x-1,y) < lowThresh)
                     es(x-1,y)=0;
               elseif(es(x-1,y)> lowThresh)
                     es(x-1,y)=255;
               end
           end
           if(eo(x,y) == 45)
               if(es(x+1,y+1) < lowThresh)
                     es(x+1,y+1)=0;
               elseif(es(x+1,y+1)> lowThresh)
                     es(x+1,y+1)=255;
               end
               if(es(x-1,y-1) < lowThresh)
                     es(x-1,y)=0;
               elseif(es(x-1,y-1)> lowThresh)
                     es(x-1,y-1)=255;
               end
           end
           if(eo(x,y) == 90)
               if(es(x,y+1) < lowThresh)
                     es(x,y+1)=0;
               elseif(es(x,y+1)> lowThresh)
                     es(x,y+1)=255;
               end
               if(es(x,y-1) < lowThresh)
                     es(x,y-1)=0;
               elseif(es(x,y-1)> lowThresh)
                     es(x,y-1)=255;
               end
           end

         if(eo(x,y) == 135)
               if(es(x-1,y+1) < lowThresh)
                     es(x-1,y+1)=0;
               elseif(es(x-1,y+1)> lowThresh)
                     es(x-1,y+1)=255;
               end
               if(es(x+1,y-1) < lowThresh)
                     es(x+1,y-1)=0;
               elseif(es(x+1,y-1)> lowThresh)
                     es(x+1,y-1)=255;
               end
         end
        end
    end
end
finalmatrix=es;
end

