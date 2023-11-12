% 一、单轴涡喷

% 1.参数设定
%% 参数带_为总参数，，不带为静参数
H=0;Ma=0;T0_ = 288.15; P0_ = 101325;Qm = 65;r=1.4;k=1.33; Cpr=1.005;Cpk=1.244;R=287;A5=0.2417;

piC_= 8.75; T3_ = 1180;
Cta_in = 1; Cta_b = 0.905; ibuc = 0.97;Hu=42900; Cta_e = 0.93; %总压恢复系数进气道 燃烧 燃烧放热 单位热量 尾喷

ita_c_ = 0.775; ita_t_ = 0.874; ita_m_ = 0.98; Vcol=0.03;%效率

% 2.参数计算
%%
% 进气道进口
T1_ = T0_                                                                  %T1_
P1_ = P0_                                                                  %P1_ 

% 进气道出口
P2_ = P1_*piC_                                                             %P2_

syms T2_
eqn = (T2_-fix(T1_))*ita_c_ == fix(T1_)*(piC_^((r-1)/r)-1);
T2_ = solve(eqn, T2_);T2_=vpa(T2_)%vpa取整                                 %T2_

% 燃烧室出口
P3_=P2_*Cta_b                                                              %P3_
T3_ = T3_                                                                  %T3_
%f=qmf/qma=Cpr*(T3_-T2_)/(Hu*ibuc)
f=Cpr*(T3_-T2_)/(Hu*ibuc)                                                  %f

% 涡轮出口
% Wt * ita_m_ = Wc
syms T4_
eqn = Cpr*(1+f-Vcol)*(T3_-T4_)*ita_m_ == Cpr*(T2_-T1_);
T4_ = solve(eqn, T4_);T4_=vpa(T4_)                                         %T4_
%ita_t_ = Wts/Wt
syms piT_
eqn = Cpr*T3_*(1-piT_^((r-1)/-r))*ita_t_ == Cpr*(T3_-T4_);
piT_ = solve(eqn, piT_);piT_=vpa(piT_)
P4_ = P3_/piT_                                                             %P4_

%尾喷管出口
P5_ = P4_*Cta_e                                                            %P5_

P0=P0_;
picr=P5_ /P0
if picr >= 1.85 %超临界
    Ma5=1;
    P5 = P5_ * 0.54
    T5_ = T4_                                                              %T5_1
    T5=T5_*0.8464; 
    v0=0;v5 = (r*R*T5)                                                     %v5_1
    F = A5*P0*(P5_/P0*1.2591-1)-Qm*v0
    
else  %亚临界
    P5=P0;T5_=T4_;                                                         %T5_2
    Ma5 = ((2/(r-1))*((P5_/P5)^((r-1)/r)-1))^0.5;
    T5 = T5_*(1+(r-1)/2*Ma5^2)^-1;
    v0=0;v5 = (r*R*T5)                                                     %v5_2
    F = Qm*(1+f)*v5-Qm*v0+A5*(P5-P0)

end
Fs=F/Qm
sfc=3600*f*(1-Vcol)/Fs





