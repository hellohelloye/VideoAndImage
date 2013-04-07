function [ ] = getFinalImg(Is,finalList,N )
s=size(finalList);
for a=1:s
    if(finalList(a,1)~=0)
        ii=finalList(a,2);
        jj=finalList;
        for q= jj-N:jj+N
            Is(ii-N,q)=225;
        end
        for q=jj-N:jj+N
            Is(ii+N,q)=225;
        end
        for q= ii-N:ii+N
            Is(q,jj-N)=225;
        end
        for q=ii-N:ii+N
            Is(q,jj+N)=225; 
        end
    end
end
imshow(uint8(Is));
end

