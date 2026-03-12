%--------------------------------------Bài 1 --------------------
disp('BAI 1:');
dd = [12; 20];
mm = [11; 03];

% a) N?i 2 vector thành 1 vector
date_vector = [dd; mm];

% b) N?i 2 vector thành 1 vector 2 chi?u 2x2
date_matrix = [dd, mm];

% c) Th?c hi?n các phép toán c?ng tr? 
add_result = dd + dd;
sub_result = dd - dd;

% d) Th?c hi?n các phép toán nhân chia 
mult_result = dd .* dd;
div_result = dd ./ dd;

% Hi?n th? k?t qu?
disp('a) Vector sau khi noi:');
disp(date_vector);

disp('b) Matrix sau khi noi:');
disp(date_matrix);

disp('c) Phep Toan cong, tru 2 vector:');
disp('Cong:');
disp(add_result);
disp('Tru:');
disp(sub_result);

disp('d) Phep Toan nhan, chia 2 vector:');
disp('Nhan:');
disp(mult_result);
disp('Chia:');
disp(div_result);
%------------------- Bài 2-------------------
disp('BAI 2:');
% T?o ma tr?n 4x4trong kho?ng [-10, 10]
matrix_4x4 = randi([-10, 10], 4, 4);

% Hi?n th? ma tr?n g?c
disp('Ma tran goc:');
disp(matrix_4x4);

% a) C?ng m?i ph?n t? c?a ma tr?n cho 15
matrix_added_15 = matrix_4x4 + 15;
disp('a)');
disp(matrix_added_15);

% b) Bình ph??ng m?i ph?n t? c?a ma tr?n
matrix_squared = matrix_4x4.^2;
disp('b)');
disp(matrix_squared);

% c) C?ng thêm 10 vào ph?n t? ? dòng 1 và dòng 2
matrix_added10r = matrix_4x4;
matrix_added10r(1:2, :) = matrix_added10r(1:2, :) + 10;
disp('c)');
disp(matrix_added10r);

% d) C?ng thêm 10 vào ph?n t? ? c?t 1 và c?t 4
matrix_addedl0 = matrix_4x4;
matrix_addedl0(:, [1, 4]) = matrix_addedl0(:, [1, 4]) + 10;
disp('d)');
disp(matrix_addedl0);

% e) ??i v? trí c?t 2 và c?t 3
matrix_swapped = matrix_4x4(:, [1, 3, 2, 4]);
disp('e)');
disp(matrix_swapped);

% f) Thêm c?t g?m các s? 0 vào c?t th? 5
matrix_zero_col = [matrix_4x4, zeros(4, 1)];
disp('f)');
disp(matrix_zero_col);

% g) Thêm dòng g?m các s? 1 vào dòng th? 2
matrix_ones_row = [matrix_4x4; ones(1, 4)];
disp('g)');
disp(matrix_ones_row);

% h) Xoá dòng th? 4
matrix_row_4 = matrix_4x4;
matrix_row_4(4, :) = [];
disp('h)');
disp(matrix_row_4);

