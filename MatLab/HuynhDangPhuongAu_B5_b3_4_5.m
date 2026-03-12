%-----------------Bài 3--------------------
%Ví d?:
a = 1;
b = 5;
c = 6;
[x1, x2] = HuynhDangPhuongAu_B5_b3_func(a, b, c);

%------------------Bài 4---------------------
A = [2, 1, 5, 1;
     1, 1, -3, -4;
     3, 6, -2, 1;
     2, 2, 2, -3];
B = [5; -1; 8; 2];
X = A \ B;
disp('Nghiem cua phuong trinh:');
disp(X);
%-----------------Bài 5---------------------
% x^2 - 3x + 2 = 0
syms x1;
eq1 = x1^2 - 3*x1 + 2 == 0;
sol1 = solve(eq1, x1);

% x^2 + x - 2 = 0
syms x2;
eq2 = x2^2 + x2 - 2 == 0;
sol2 = solve(eq2, x2);

disp('Nghiem cua phuong trinh x^2 - 3x + 2 = 0 :');
disp(sol1);

disp('Nghiem cua phuong trinh x^2 + x - 2 = 0:');
disp(sol2);
