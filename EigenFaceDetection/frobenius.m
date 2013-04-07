%..........................................................
%Yukui Ye HW4  full_e.m is for caculating frobenius
%........................................................
clear;close all;clc;

%.........................................................................
%get the whole traning set ImageMatrix as well as its average
fileName = dir('C:\Users\yye_000\Documents\MATLAB\yalefaces_centered_small\*.jpg');
numberImgs = length(fileName);
imgs = cell(numberImgs,1);
imgMatrix (1:154*116,1:numberImgs)=0;
for i= 1: numberImgs
    imgs{i} = imread( fileName(i).name );
    imgMatrix(:,i) = reshape(imgs{i},154*116,1);
end
average = mean(imgMatrix,2);
%......................................................................
%calcuate eigenVector
numImg = size(imgMatrix,2);
%compute difference with average for each vector
A = imgMatrix - repmat(average,1,numImg);
tic;
%covariance matrix
Cmatrix = A'*A;
[V D] = eig(Cmatrix);
%sort 
D = abs(diag(D));
[evalue sort_idx] = sort(D,'descend');
V = V(:,sort_idx);
V = V(:,1:numberImgs);
mVector = A*V;
toc;
eVector = zeros(17864,numberImgs);
for i = 1:numberImgs
    a = 0;
    for j = 1:17864
        a = a + mVector(j,i)^2;
    end
    base = sqrt (a);
    eVector(:,i) = mVector(:,i)/base;
end
%.........................................................................
%get TestSet Image matrix
fileName2 = dir('C:\Users\yye_000\Documents\MATLAB\yalefacesTestSet\*.jpg');
numberImgs2 = length(fileName2);
imgs = cell(numberImgs2,1);
testMatrix (1:154*116,1:numberImgs2)=0;
for i= 1: numberImgs2
    imgs{i} = imread( fileName2(i).name );
    testMatrix(:,i) = reshape(imgs{i},17864,1);
end
%.......................................................................
%get testSetImageMatrix's WeightMatrix
numImg3 = size(testMatrix,2);
m = testMatrix - repmat(average,1,numImg3);
%weightMatrix = eVector' * m; //another way to caculate weightMatrix
weightMatrix(1:numberImgs2,1:numberImgs) = 0;
for i = 1:numberImgs2
    for j = 1:numberImgs
    weightMatrix(i,j) = (eVector(:,j))'*m(:,i);
    end
end
%.......................................................................
%reconstruct the test image and test one of it
mMatrix = zeros(17864,20);
for i = 1:numberImgs
    for j = 1:numberImgs2
       mMatrix( : ,i ) =  weightMatrix(j,i)*eVector(:,j);
    end
end  
numImg4 = size( mMatrix,2);
reconstructTestMatrix = mMatrix + repmat(average,1,numImg4);
%.......................................................................
%different between original testMatrix and the reconstructMatrix...........
diff=zeros(1:17864,1:137);
diff = imgMatrix - reconstructTestMatrix;
%................
test=reshape(reconstructTestMatrix(:,19),154,116);
test2=reshape(testMatrix(:,19),154,116);
test3=reshape(diff(:,19),154,116)
subplot(1,3,1);
imshow(uint8(test));
subplot(1,3,2);
imshow(uint8(test2));
subplot(1,3,3);
imshow(uint8(test3));
%now we got the different image matrixs, do the frobenius caculation
diff2=diff'*diff;
%diff4 = norm(diff2,'fro');
%for i= 1: 137
   % diff3 = sqrt(diff2(i,:));
   diff4 = norm(diff2,'fro');
   stem(i,diff4(i));
%end




    
