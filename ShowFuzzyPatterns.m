function [] = ShowFuzzyPatterns(pathImage, sizeSubImage, U)
   % *************************************************************************
   % ExtractSubImgFeatures: show recognized patterns in red on image files
   %              
   % Example: ShowFuzzyPatterns([pwd, '/Beans.png'], 16, U)
   %           
   % Author:ddd (luiz.fersc@gmail.com) - 30/01/18
   % Update: Luiz F. S. Coletta - 07/02/18
   % ************************************************************************* 
   
   fullImage = imread(pathImage);

   red = fullImage(:,:,1);   % Red channel
   green = fullImage(:,:,2); % Green channel
   blue = fullImage(:,:,3);  % Blue channel
   fullImage = cat(3, red, green, blue);

   [rows, cols, can] = size(fullImage);

   left = 0;
   top = left;
   width = sizeSubImage;
   height = width;
   i = 1;
   
   if (U(1,1) < 0.5) 
      cluster = 1;
   else 
      cluster = 2;
   end 

   for j = 1:rows/width % iterate getting subimages from current file (lines)

      left = 0; 
      width = sizeSubImage;

      for k = 1:cols/width % iterate getting subimages from current file (columns)
       
 
         fullImage(top+1:(top+1+height),left+1:(left+1+width),1) = U(cluster,i)*255;
         %fullImage(top+1:(top+1+height),left+1:(left+1+width),2) = U(1,i)*255;
         %fullImage(top+1:(top+1+height),left+1:(left+1+width),3) = U(1,i)*255;
          
          left = left + width + 1;
          if (k == 1)
             width = width - 1;
          end 
          
          i = i+1;
          
      end 

      top = top + height + 1;
      if (j == 1)
          height = height - 1;
      end 
      
   end 
 
   figure,imshow(fullImage);
   
end
