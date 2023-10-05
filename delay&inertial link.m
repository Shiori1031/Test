%%惯性环节

% 1. 定义系统的一阶传递函数
K_1= 1;          % 增益
T_1 = 1;        % 时间常数
T_2 = 2;
sys_1 = tf(K_1, [T_1, 1]); % 创建传递函数模型 G(s) = K / (T*s + 1)
sys_2 = tf(K_1, [T_2, 1]);

% 2. 创建输入信号
t = 0:0.01:10; % 时间向量
u = sin(t);    % 正弦输入信号

% 3. 进行仿真
[y_1, t] = lsim(sys_1, u, t); % 使用lsim函数进行仿真
[y_2, t] = lsim(sys_2, u, t);

% 4. 绘制输入信号和输出信号
figure;
subplot(2,1,1);
plot(t, u);
title('输入信号');
xlabel('时间t');
ylabel('幅度u');
%处理后的
subplot(2,1,2);
plot(t, y_1); 
title('系统响应');
xlabel('时间t');
ylabel('幅度y');

% 5. 分析系统响应，观察惯性环节的影响
