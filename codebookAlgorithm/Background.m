%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%YUKUI YE   HW6 Background Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = Background(c, image)

%initialize certain parameter
threshold = 20;
alpha = 0.5;
beta = 1;
cnt = 0; 

%do BackgroundSubtraction
currentImg = imread( image );
[row,colum,~] = size(currentImg);
hold = [];

for i = 1:row
    for j = 1:colum;
        X = double([currentImg(i,j, 1), currentImg(i,j, 2), currentImg(i,j, 3)]');
        for loop = 1:length(c{i,j}(1,:));
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
               ++cnt;
                   hold(1,cnt) = i;
                   hold(2,cnt) = j;
                   break;
           end
        end
    end
end
                   
show1 = 255*ones(row, colum);
for i = 1:length(c(1, :))
    show1(hold(1, i), hold(2, i)) = 0;
end

% Morphological operation
imgOpen = imopen (show1, strel('disk', 1));
imgClose = imclose (imgOpen, strel('disk', 1));
show2 = imgClose;

figure(1); imshow(img);
figure(2); imshow(show1);
figure(3); imshow(show2);
           
end


           