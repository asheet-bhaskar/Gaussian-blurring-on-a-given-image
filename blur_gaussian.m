sigma = 10;

dim = ceil(6*sigma+1);
p2 = [dim dim];
siz   = (p2-1)/2;

[x,y] = meshgrid(-siz(2):siz(2),-siz(1):siz(1));
arg   = -(x.*x + y.*y)/(2*sigma*sigma);

h     = exp(arg);

sumh = sum(h(:));
if sumh ~= 0,
h  = h/sumh;
end;
disp(size(h));
A = imread('Mandrill.pgm');
k = h;
[r,c] = size(A);
[m,n] = size(k);
h1 = rot90(k, 2);
center = floor((size(h1)+1)/2);
left = center(2) - 1;
right = n - center(2);
top = center(1) - 1;
bottom = m - center(1);
Rep = zeros(r + top + bottom, c + left + right);
for x = 1 + top : r + top
    for y = 1 + left : c + left
        Rep(x,y) = A(x - top, y - left);
    end
end
B = zeros(r , c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : m
            for j = 1 : n
                q = x - 1;
                w = y -1;
                B(x, y) = B(x, y) + (Rep(i + q, j + w) * h1(i, j));
            end
        end
    end
end
imshow(B);
subplot(1,2,1);
imagesc(A);

subplot(1,2,2);
imagesc(B);

