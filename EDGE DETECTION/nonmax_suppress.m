function [aftNmsuppress ] = nonmax_suppress( eo,es,originalImage )
[x_size,y_size]=size(originalImage);
aftNmsuppress=zeros(x_size,y_size);
for x=2:(x_size-1)
    for y=2:(y_size-1)
        if(eo(x,y) == 0)
            if(es(x,y+1) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x,y+1) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
            if(es(x,y-1) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x,y-1) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
        end
        
        if(eo(x,y) == 45)
            if(es(x-1,y+1) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x-1,y+1) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
            if(es(x+1,y-1) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x+1,y-1) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
        end
         if(eo(x,y) == 90)
            if(es(x+1,y) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x+1,y) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
            if(es(x-1,y) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x-1,y) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
         end
        if(eo(x,y) == 135)
            if(es(x+1,y+1) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x+1,y+1) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
            if(es(x-1,y-1) < es(x,y))
                aftNmsuppress(x,y)=es(x,y);
            elseif(es(x-1,y-1) > es(x,y))
                aftNmsuppress(x,y)=0;
            end
        end
    end
    
end
end

