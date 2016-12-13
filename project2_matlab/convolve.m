% This function uses convolution operation to an image
% Input:
%   image-an image to convolve
%   kernel- structuring element nxn matrix
% Output:
%   output- convolved image

function output = convolve(image,kernel)

    [height,width,numColor]=size(image);
    if numColor == 3
        image = rgb2gray(image);
    end
    output = zeros(height,width);
    %flip the kernel
    kernel = rot90(kernel,2);
    [row col] = size(kernel);
    center = [];
    center(1) = floor(row/2) + 1;
    center(2) = floor(col/2) + 1;
    
    for i=1:height
        for j=1:width
            % Sum of Product
            SOP = 0;
            for y=1:row
                for x=1:col
                    if j-(center(2)-x) < 1 || j-(center(2)-x) > width || ...
                            i-(center(1)-y) < 1 || i-(center(1)-y) > height
                        continue;
                    else
                        SOP = image(i-(center(1)-y),j-(center(2)-x))*kernel(y,x) + SOP;
                    end
                end
            end
            output(i,j) = SOP;
        end
    end
    