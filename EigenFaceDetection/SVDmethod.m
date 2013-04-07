function [ V ] = SVDmethod( imgMatrix )

        tic;
        [U,S,V] = svd(imgMatrix);     
        toc;

end

