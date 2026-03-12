%------------------------ Bài 3---------------------

function [x1, x2] = HuynhDangPhuongAu_B5_b3_func(a, b, c)
    %  delta
    delta = b^2 - 4*a*c;
    % Ki?m tra ?i?u ki?n delta
    if delta < 0
        disp('Ph??ng trình không có nghi?m th?c.');
        x1 = NaN;
        x2 = NaN;
    else
        % Nghi?m
        x1 = (-b + sqrt(delta)) / (2*a);
        x2 = (-b - sqrt(delta)) / (2*a);
        
        disp('Nghiem cua phuong trinh:');
        disp(['x1 = ', num2str(x1)]);
        disp(['x2 = ', num2str(x2)]);
    end
end



