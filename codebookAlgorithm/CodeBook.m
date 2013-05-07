%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%YUKUI YE   HW6 CodeBook Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all; clc;
%Read test training set images
filename = dir('C:\Users\yye_000\Documents\MATLAB\*.jpg');
numberImgs =  length(filename);
%initialize certain parameter
threshold = 20;
alpha = 0.5;    
beta = 1;      
%initialize c{i.j}
for i = 1:288       
    for j = 1:384 
        C{i,j} = [];
    end
end
%start the algorithm
for k = 1:numberImgs
    currentImg = imread( filename(k).name );
    [row,colum,~] = size(currentImg);
    XX = currentImg;
    Imatrix = mean(XX,3);
    for i = 1:row 
        for j = 1:colum;
            
            if( isempty( C{i,j} ))
                L = 0;
            else
                L = length( C{i,j}(1,:) );
            end
            X = double([currentImg(i,j, 1), currentImg(i,j, 2), currentImg(i,j, 3)]');
            if ( L ~= 0)                 
                for  loop = 1:L
                    V = C{i,j}(7:9,loop );
                    Imin = C{i,j}(1,loop);
                    Imax = C{i,j}(2,loop);  %%%%%%%%%%%%%%%%%%%  calculate colodist %%%%%%%%
                    low = Imin * alpha;
                    hight = min( [Imax*beta, Imin/alpha]);
                    xsquare = sum(X.^2);
                    vsquare = sum(V.^2);
                    psquare = ( sum(X.*V)^2 )/vsquare;
                    colordist = sqrt ( xsquare - psquare);%%%%%%%%  calculate brightness  %%%%%
                    I = mean(X);
                    if (I >= low && I <= hight)
                        brightness = true;
                    else
                        brightness = false;
                    end
                    if(colordist <= threshold && brightness == true) %%%%% find the match %%%%%%
                        Imin = min(Imatrix(i,j), C{i,j}(1,loop));
                        Imax = max(Imatrix(i,j), C{i,j}(2,loop));
                        f = C{i,j}(3,loop) + 1;
                        lamda = max(C{i,j}(4,loop),(k - C{i,j}(6,loop)));
                        p = C{i,j}(5,loop);
                        q = k;
                        vr = ((C{i,j}(3,loop)*C{i,j}(7,loop) )+ X(1))/f;
                        vg = ((C{i,j}(3,loop)*C{i,j}(8,loop) )+ X(2))/f;
                        vb = ((C{i,j}(3,loop)*C{i,j}(9,loop) )+ X(3))/f;
                        C{i,j}(:,loop) = [Imin,Imax,f,lamda,p,q,vr,vg,vb]';
                    else  %%%%%%%%%% if not find the match  %%%%%%%%%%
                        L = L+1;
                        C{i,j}(:,L) = [Imatrix(i,j),Imatrix(i,j),1,k-1,k,k,X(1),X(2),X(3)]';
                    end
                end 
            else %%%%%%% if L = 0  do setup thing %%%%%%%
                L = L+1;
                C{i,j}(:,L) = [Imatrix(i,j),Imatrix(i,j),1,k-1,k,k,X(1),X(2),X(3)]';
            end
        end
    end
end

%  Maximun Negative Run Length 
for i = 1: row
    for j = 1: colum
        for k = 1: length( C{i,j}(1,:))
            C{i,j}(4,k) = max( C{i,j}(4,k),(numberImgs - C{i,j}(6,k) + C{i,j}(5,k)-1));
        end
    end
end

save('C.mat','C');

            
            
                
                    
                    
                    
                
        


