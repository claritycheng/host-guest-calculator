%定义已知量
h0=1e-6;
g0=1e-6;
Ka=1e6;
% 定义方程 x(1) = h x(2) = hg x(3) = g 
eq1 = @(h, hg) h + hg - h0;
eq2 = @(hg, g) g + hg - g0;
eq3 = @(h, hg, g) hg - Ka * h*g;

%设置求解精度
functolerance = min(h0,g0)*1e-3;
septtolerance = functolerance*1e-3;
options = optimoptions('fsolve', 'FunctionTolerance', functolerance, 'StepTolerance', septtolerance,'Algorithm', 'levenberg-marquardt');

% 求解方程组
z = fsolve(@(x) [eq1(x(1), x(2)); eq2(x(2), x(3)); eq3(x(1),x(2),x(3))], [h0, g0, g0], options);

disp(z);

%计算百分比
percent = z(2)/g0;
percentValue = sprintf('%.2f%%', percent*100);
%app.ComplexConcentrationMEditField.Value = percentValue;