pkg load statistics
pkg load image

function [val] = RMI(name1, name2)
  I1 = imread(name1);
  [N, M, ~] = size(I1);
  A = double(I1(:,:,1));
  I2 = imread(name2);
  B = double(I2(:,:,1));
  L = 256;
  pab = zeros(L,L);
  for x = 1:N
     for y = 1:M
         pab(A(x,y)+1, B(x,y)+1) = pab(A(x,y)+1, B(x,y)+1) + 1;
     end
  end
  sumab = sum(sum(pab));
  pab = pab / sumab;
  pa = sum(pab,2);
  pb = sum(pab,1);
  L = 256;
  hA = 0;
  for i = 1 : L
    if pa(i)
        hA = hA - pa(i) * log(pa(i));
    end
  end
  hB = 0;
  for i = 1 : L
    if pb(i)
        hB = hB - pb(i) * log(pb(i));
    end
  end
  hAB = 0;
  for i = 1 : L
    for j = 1 : L
        if pab(i,j)
            hAB = hAB - pab(i,j) * log(pab(i,j));
        end
    end
  end
  val = (hA + hB - hAB) / hA;
end

function [TFDh] = motion_blur(n, m, b, T)
  TFDh = zeros(n, m);
  for x = 1:n
    for y = 1:m
       TFDh(x, y) = ((T * sin(pi * y * b)) / (pi * y * b)) * exp(-pi * i * y * b);
    end
    TFDh(x, 1) = 1;
  end
end

imageName = '1.jpg';

I = imread(imageName);
J = I(:,:,1);
[n,m] = size(J);
f = double(J);

TFDf = fft2(f);
TFDh = motion_blur(n, m, 0.002, 1);

TFDg = zeros(n,m);
for x = 1:n
  for y = 1:m
    TFDg(x,y) = TFDh(x,y) * TFDf(x,y);
  end
end

g = real(ifft2(TFDg));
imwrite(uint8(g), 'disturbed_image.jpg');

TFDf = TFDg;
for i = 1:n
    for j = 1:m
      if (abs(TFDh(i,j)) > 0.01)
        TFDf(i,j) = TFDg(i,j) / TFDh(i,j);
      end
    end
end

fr = real(ifft2(TFDf));
imwrite(uint8(fr), 'restored_image.jpg');

rmi_o_d = RMI(imageName, 'disturbed_image.jpg');
rmi_o_r = RMI(imageName, 'restored_image.jpg');

figure;
subplot(1, 3, 1);
imshow(uint8(I));
title('Original image');
subplot(1, 3, 2);
imshow(uint8(g));
title('Blurred image');
subplot(1, 3, 3);
imshow(uint8(fr));
title('Restored image');

str1 = ['RMI disturbed image vs. original image: ' num2str(rmi_o_d)];
str2 = ['RMI restored image vs. original image: ' num2str(rmi_o_r)];
annotation('textbox', [.4 .1 .4 .05], 'String', [str1], 'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14);
annotation('textbox', [.4 .06 .4 .05], 'String', [str2], 'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14);
