function [dataset] = ExtractSubImgFeatures(pathImage, sizeSubImage, normalize)
   % *************************************************************************
   % ExtractSubImgFeatures: extract features from subimages
   %                        
   % Example: [dataset] = ExtractSubImgFeatures([pwd, '/Beans.png'], 16, true)
   %           
   % Author: Luiz F. S. Coletta (luiz.fersc@gmail.com) - 30/01/18
   % Update: Luiz F. S. Coletta - 07/02/18
   % ************************************************************************* 
  
   left = 0;
   top = left;
   width = sizeSubImage;
   height = width;

   fullImage = imread(pathImage);

   red = fullImage(:,:,1);   % Red channel
   green = fullImage(:,:,2); % Green channel
   blue = fullImage(:,:,3);  % Blue channel
   fullImage = cat(3, red, green, blue);

   [rows, cols, can] = size(fullImage);
   
   dataset = [];
   
  
   n=0;

       for j = 1:rows/width % iterate getting subimages from current file (lines)

        left = 0; 
        width = sizeSubImage;

      
      
      
      for k = 1:cols/width % iterate getting subimages from current file (columns)

          subImage = imcrop(fullImage, [left, top, width, height]); % left, top, width, height]

     %     figure, imshow(subImage)

          left = left + width + 1;
          if (k == 1)
             width = width - 1;
          end 
       
        
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%

          avg_rgb= [mean(mean(subImage(:,:,1))),mean(mean(subImage(:,:,2))),mean(mean(subImage(:,:,3)))];
         
          s = single(subImage);
         
          r = reshape (s(:,:,1),1,size(s(:,:,1),1)*size(s(:,:,1),2));
          rh = hist(r, 3);
          
           g = reshape (s(:,:,2),1,size(s(:,:,2),1)*size(s(:,:,2),2));
          gh = hist(g, 3);
          
           b = reshape (s(:,:,3),1,size(s(:,:,3),1)*size(s(:,:,3),2));
          bh = hist(b, 3);
          
          hist_rgb = [rh, gh, bh];
          
          dataset = [dataset; avg_rgb];
        
      end 

      top = top + height + 1;
      if (j == 1)
          height = height - 1;
      end 

   end 

   if (normalize == true) 
       minVal = min(dataset);
       maxVal = max(dataset);
       norm_data = [];
       for m = 1:size(dataset,2)
           norm_data = [norm_data, (dataset(:, m) - minVal(m))/(maxVal(m) - minVal(m))];
       end 
       dataset = norm_data;
   end
       
end
