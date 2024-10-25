%%
%%分号;会隐藏命令行的输出结果
%%

a= [
        1 2 3
        4 5 6
        7 8 9
   ];
a1 = [
         1 2
         -1 -3
];
b=a1'   ;            %矩阵转置
c=a1(:)       ;      %矩阵按列拉长
d=inv(a1)  ;         %求逆矩阵
e=zeros(10,5,3)  ;   %3维10行5列全0矩阵  3个矩阵 
e( :,  :, 1) = rand(10,5);  %10行5列随机数
e( :,  :, 2) = randi(6,10,5);%从0到6生成10行5列的矩阵
e( :,  :, 3) = randn(10,5);%生成10行5列的标准正态分布矩阵

A=cell(1,6);%计数（角标）从1开始
A{2} = eye(3);%3*3的对角线为1的单位矩阵
A{5} = magic(5); %生成n阶幻方 使得每列每行对角线的和相等
B = A{5};


books = struct('name',{{'aaa','bbb'}},'price',[32 45]);
books.name
books.name(1)
books.name{1};
%%
%矩阵构造
%%
A= [
        1 2 3
        4 5 6
        7 8 8
   ];
B=1:2:9;
C=repmat(B,3,2);%横着重复2次 竖着重复3次B
D=ones(4,4);%4行4列的全1矩阵

%%
%矩阵运算
%%
A= [
        1 2 3 4 
        5 6 7 8
   ];
B= [
        1 1 2 2 
        2 2 1 1
   ];
C=A+B;
D=A-B;
E=A*B';
F=A.*B ; %  . 对应项相乘
G=A/B   ;%  G*B=A  等价于A*B逆矩阵inv(B) 
H=A./B  ;%  . 对应项相除

%%
%矩阵下标
%%

A=magic(5);
B=A(2,3);
C=A(2,:)  ; % : 取全部
D=A(:,2)  ; % : 取全部
[m,n]=find(A>20); %找出大于20的 序号值/矩阵（m行n列）
[m,n]=find(A==1);

%%
% 程序结构
%%
% for
sum=0;
for n=1:1:5
    sum=sum+n^2;

end
% while
i=0;
while i<=10
    sum=sum+i;
    i=i+1;
end
% if
a=1;
b=2;
if a>b
    'a>b';
elseif a==b
   'a=b';
else a<b;
    'a<b';

end

%%
%二维平面的绘制
%%
x=0:0.01:2*pi ; %pi 圆周率Π
y=sin(x);
figure% 建立一个幕布
plot(x,y)%绘制当前的二维平面图
title('y=sin(x)')%添加一个标题
xlabel('X')
ylabel('sin(x)')
xlim([0 2*pi])  %x的范围
%%
x=0:0.01:2*20 ;
y1=200*exp(-0.05*x).*sin(x);
y2=0.8*exp(-0.5*x).*sin(10*x);

figure% 建立一个
p = plot(1:10);
set(p,'Color','b')
[AX,H1,H2] = plotyy(x,y1,x,y2);%plotyy  公用一个坐标系
set(get(AX(1),'Ylabel'),'String','Slow Dency')
set(get(AX(2),'Ylabel'),'String','Fast Dency')
title('Multiple Decay Rates')
xlabel('Time(\musec)')
set(H1, 'LineStyle','--')
set(H2, 'LineStyle',':')
%% yyaixs
% 创建一些示例数据
x = 1:10;
y1 = sin(x);
y2 = cos(x);

% 使用 plotyy 绘制双 y 轴图形
figure;
[ax, h1, h2] = plotyy(x, y1, x, y2);

% 修改第一个 y 轴的标签
ylabel(ax(1), 'Sin Values');

% 修改第二个 y 轴的标签
ylabel(ax(2), 'Cos Values');

% 使用 yyaxis 绘制相同的图形
figure;
yyaxis left;
plot(x, y1);
ylabel('Sin Values');

yyaxis right;
plot(x, y2);
ylabel('Cos Values');
%%


 t = 0:pi/50:2*pi ;
 x = 16*sin(t).^3 ;
 y = 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t) ;
 scatter(x,y,'rd','filled')

%%
%三维立体绘图
%%
t = 0:pi/50:10*pi;
plot3(sin(t),cos(t),t);
xlabel('x:sin(t)');
ylabel('y:cos(t)');
zlabel('z:t');
%hold on %保留当前的绘图 <——>hold off
grid on %显示坐标区的网格线
axis square %设置坐标轴范围和纵横比 把显示范围变成正方形



[X,Y,Z] = peaks(25);
CO(:,:,1) = zeros(25); % red
CO(:,:,2) = ones(25).*linspace(0.5,0.6,25); % green
CO(:,:,3) = ones(25).*linspace(0,1,25); % blue
mesh(X,Y,Z,CO)

%%
%solve函数
%%
syms x
eqn = 2*x + 1 == 0;
x = solve(eqn, x)

%%
% 函数定义
%%
function result = add(a, b)
    % 函数名: add
    % 输入参数: a, b
    % 输出结果: result
    result = a + b;
end

