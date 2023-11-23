% 二、分别排气涡扇发动机

% 1.参数设定
%% 参数带_为总参数，，不带为静参数
H=11;Ma0=0.1;Qm = 65;r=1.4;k=1.33; Cpr=1.005;Cpk=1.244;R=287;A9=0.2417;
B=0.4;
piLc_= 3.8; piHc_= 4.474; T4_ = 2000;
Cta_in_max=0.97;  Cta_out=0.98; Cta_b=0.97;ibuc=0.98;Hu=42900; Cta_e=0.98; 
% 总压恢复系数进气道 外涵道         燃烧           单位热量    尾喷

ita_Lc_ = 0.868;ita_Hc_ = 0.878; ibuc = 0.98; ita_Lt_ = 0.91; ita_Ht_ = 0.89;ita_Lm_ = 0.98;ita_Hm_ = 0.98;%效率
ita_mp=0.98;Ct0=3;%风扇提取效率 相对功率提取因数
Vcol=0.01;Vc1=0.05;Vc2=0.05;
% 2.参数计算
%% 低压增压比
%piLc_= 3.8;
tuili=[];haoyou=[];
for zengya=3:0.1:10
    if H<11
        T0 = 288.15-6.5*H;P0 =101330*(1-H/44.308)^5.2553;                  %P0_1 T0_1
    else
        T0 = 216.7;P0 = 22700*exp((11-H)/6.338);                           %P0_2 T0_2
    end
    
    v0 = Ma0*(r*R*T0)^0.5                                                  %v0
    P0_=P0*(1+(r-1)/2*Ma0^2)^(r/(r-1))                                     %P0_
    T0_=T0*(1+(r-1)/2*Ma0^2)                                               %T0_
    
    % 进气道出口2站位
    if Ma0 <= 1
        Cta_in = Cta_in_max;
    else
        Cta_in = Cta_in_max*(1-0.075*(Ma0-1)^1.35);
    end
    
    P2_=P0_*Cta_in                                                         %P2_
    T2_=T0_                                                                %T2_
    
    % 风扇出口22站位
    P22_=P2_*zengya
    
    % ita_c_ = Wc/Wcs
    syms T22_
    eqn = Cpr*(T22_-T2_)*ita_Lc_ == Cpr*T2_*(zengya^((r-1)/r)-1);
    T22_ = solve(eqn, T22_)                                                %T22_   
    WLc = Cpr*(T22_-T2_)                                                   %WLc 
    
    % 高压压气机出口3站位
    P3_=P22_*piHc_                                                         %P3_
    
    % ita_c_ = Wcs/Wc
    syms T3_
    eqn = Cpr*(T3_-T22_)*ita_Hc_ == Cpr*T22_*(piHc_^((r-1)/r)-1);
    T3_ = solve(eqn, T3_)                                                  %T3_   
    WHc = Cpr*(T3_-T22_)                                                   %WHc 
    
    % 燃烧室出口4站位
    T4_=T4_                                                                %T4_  
    P4_=P3_ *Cta_b                                                         %P4_
    
    % 燃烧室能量守恒 Q3a*h3_ +Qf*Hu*Cta_b=(Q3a+Qf)*h4_
    % f=Qf/Q3a
    f=(Cpk*T4_-Cpr*T3_)/(Hu*ibuc-Cpk*T4_);f=vpa(f)                         %f
    % 流入燃烧室的流量
    Q3a=Qm*(1-Vcol-Vc1-Vc2)                                                %Q3a
    % 流出燃烧室的流量
    Qf=Q3a*f;
    Q4=Q3a+Qf                                                              %Q4
    
    % 高压涡轮后45站位
    
    % 流入高压涡轮的流量
    Q4a=Q4+Qm*Vc1                                                          %Q4a
    % 流入高压涡轮前45处能量守恒
    syms T4a_
    %冷却+燃气=总推气
    eqn= Cpr*Qm*Vc1*T3_ + Cpk*Q4*T4_==Cpk*Q4a*T4a_;
    T4a_=solve(eqn, T4a_);T4a_=vpa(T4a_)                                   %T4a
    P4a_=P4_                                                               %P4a
    
    % WHt * ita_Hm_ = WHc
    syms T45_
    eqn = Cpk*Q4a*(T4a_-T45_)*ita_Hm_ == Cpr*Qm*(T3_-T22_);
    T45_ = solve(eqn, T45_); T45_=vpa(T45_)                                %T45_
    
    % ita_Ht_ = WHt/WHts
    syms piHt_
    eqn = Cpk*T4a_*(1-piHt_^((k-1)/-k))*ita_Ht_ == Cpk*(T4a_-T45_);
    piHt_ = solve(eqn, piHt_);piHt_=vpa(piHt_)                             %piHt
    P45_ = P4_/piHt_                                                       %P45_
    
    %低压涡轮出口5站位
    % 流入低压涡轮的流量
    Q4c = Q4a + Qm*Vc2                                                     %Q4c
    
    % 流入低压涡轮的总能量守恒
    % W45+Wc2=W4c
    syms T4c_
    eqn = Cpk*Q4a*T45_+Cpr*Qm*Vc2*T3_==Cpk*Q4c*T4c_;
    T4c_ = solve(eqn,T4c_);T4c_=vpa(T4c_)                                  %T4c_
    P4c_ = P45_                                                            %P4c_
    
    % WLt * ita_Lm_ = WLc
    syms T5_
    eqn= Q4c*Cpk*(T4c_-T5_)*ita_Lm_==Qm*(Cpk*(T22_-T2_)+Ct0/ita_mp)*(1+B);
    T5_ = solve(eqn,T5_);T5_=vpa(T5_)                                      %T5_
    
    % ita_Lt_ = WLt/WLts
    syms piLt_
    eqn = Cpk*T4c_*(1-piLt_^((k-1)/-k))*ita_Lt_ == Cpk*(T4c_-T5_);
    piLt_ = solve(eqn, piLt_);piLt_=vpa(piLt_)                             %piLt
    P5_ = P4c_/piLt_                                                       %P5_
    
    %尾喷出口9站位
    P9_=P5_*Cta_e                                                          %P9_                                                                 
    T9_ = T5_                                                              %T9_1
    %判断喷管状态
    picr=P9_ /P0
    if picr >= 1.85 %超临界
        Ma9=1;
        P9 = P9_ * 0.54
        T9=T9_*0.8464; 
        v9 = (k*R*T9)^0.5*Ma9                                              %v5_1
        F = (A9*P9_*1.2591-Qm*v0-P0*A9)*(1+B)
        
        
    else  %亚临界
        P9=P0;
        %mpower((P9_/P9),((k-1)/k)-1)
        Ma9 = ((2/(k-1))*(mpower((P9_/P9),((k-1)/k)-1)))^0.5;
        T9 = T9_*(1+(k-1)/2*Ma9^2)^-1;
        v9 = (r*R*T9)^0.5*Ma9                                              %v5_2

        F = (Q4c*v9-Qm*v0)*(1+B)
    
    end
    Fs=F/Qm                                                                %Fs
    tuili(end+1) = Fs;
    sfc=3600*f*(1-Vcol-Vc1-Vc2)/Fs                                         %sfc
    haoyou(end+1) = sfc;
    
end
zengya=3:0.1:10
y1=tuili;
y2=haoyou;

figure;% 建立piC变画布
[AX,H1,H2] = plotyy(zengya,y1,zengya,y2);%plotyy  公用一个坐标系
set(get(AX(1),'Ylabel'),'String','单位推力')
set(get(AX(2),'Ylabel'),'String','耗油率')
title('低压增压比的影响')
xlabel('增压比')
set(H1, 'LineStyle','--')
set(H2, 'LineStyle',':')
