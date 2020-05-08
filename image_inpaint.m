%% Remove Objects in Image Using Inpainting
%I = imread('liftingbody.png');
I = imread('170605_1.jpg');
figure,imshow(I)

%%
num = 3;
switch num
    case 1
        h = drawellipse('Center',[410 155],'SemiAxes',[95 20]);
    case 2
        h = drawfreehand;
    case 3
        h = drawassisted;
end
%%
mask = createMask(h);
figure,montage({I,mask});
title(['Image to Be Inpainted',' | ','Mask for Inpainting'])
%%
% J = inpaintExemplar(I,mask,'PatchSize,'[9 9]','FillOrder','tensor');
J = inpaintExemplar(I,mask); 
figure,montage({I,J});
title(['Image to Be Inpainted',' | ','Mask for Inpainting'])


%% Mix
alphamat = imguidedfilter(single(mask),I,'DegreeOfSmoothing',2);
target = imread('fabric.png');
%target = imread('targe01.jpg');
figure,imshow(target)
%% 
alphamat = imresize(alphamat,[size(target,1),size(target,2)]);
I = imresize(I,[size(target,1),size(target,2)]);

%%
fused = single(I).*alphamat + (1-alphamat).*single(target);
fused = uint8(fused);
figure,imshow(fused)