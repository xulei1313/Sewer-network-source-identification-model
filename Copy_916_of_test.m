delete('D:\180108.inp')
delete('D:\180108.rpt')
delete('D:\180108.txt')
fclose('all')
clc
clear
%  format long %设置为小数点后9位
T = 2000; % Set the maximum number of iterations
sigma =10000; % Set standard deviation of normal proposal density
Mmin = 500000; Mmax = 1500000; % define a range for starting values
M= zeros( 1 , T ); % Init storage space for our samples
 M(1)= unifrnd( 900000 , 1100000 );  % Generate start value
% M(1)=100000;
%% Start saNmplin
Jmin=1;Jmax=65;
timemin=0;timemax=120;
 J_1=randint(1,1,[20 40]);
hour=2;
 time_1=round(unifrnd(50,70));
for t=1:T                                                                     %开始抽样
    t
    M(t+1) = normrnd(M(t), sigma);
    p=unifrnd(0,1); 
    q=unifrnd(0,1);
    
    if((p>0.5)&&(time_1<(60*hour)))
        time_2=time_1+1;
    elseif((p<=0.5)&&(time_1>1))
        time_2=time_1-1;
    else
        time_2=time_1;
    end
    
    if((q>0.5)&&(J_1<65))
        J_2=J_1+1;
    elseif((q<=0.5)&&(J_1>1))
        J_2=J_1-1;
    else
        J_2=J_1;
    end
         Y_Star_record(t)=Copy_916_of_Untitledjicheng6(num2str(M(t+1)),time_2,num2str(J_2));
        Y_n_record(t)=Copy_916_of_Untitledjicheng6(num2str(M(t)),time_1,num2str(J_1));
%     Y_Star_record(t)=Copy_L915_of_Untitledjicheng6(num2str(M(t+1)),time_2,num2str(J_2));
%     Y_n_record(t)=Copy_L915_of_Untitledjicheng6(num2str(M(t)),time_1,num2str(J_1));
   alpha = min([1 0.2*Y_Star_record(t)/Y_n_record(t)]);
    u = rand;
    if u >= alpha
        M(t+1) = M(t);% If not, copy old state
         time_1=time_1;
        J_1=J_1;
    else
        M(t+1) = M(t+1);
        time_1=time_2;
        J_1=J_2;
    end
    
    time_record(t)=time_1;
    M_record(t)=M(t);                                      %输出每一个参数的中值及均值 
    J_record(t)=J_1;
    Ma=mean(M_record);
    Mb=median(M_record);
    Ta=mean(time_record);
    Tb=median(time_record);
    Ja=mean(J_record);
    Jb=median(J_record);
end
% %% Display histogram of our samples
 figure( 1 ); 
 clf;
 subplot( 3,1,1 );
 nbins = 100;
 Mbins = linspace( Mmin , Mmax , nbins );
 counts = hist( M , Mbins );
   bar( Mbins , counts/sum(counts) , 'k' );
%    bar( Mbins , counts, 'k' );
 xlim( [ Mmin Mmax ] );
 xlabel( 'M（g）' ); ylabel( 'p(M)' );                                            %直方图
  figure( 2 ); 
 clf;
 subplot( 3,1,1 );
 nbins = 100;
 Jbins = linspace( Jmin , Jmax , nbins );
 counts = hist( J_record , Jbins );
   bar( Jbins , counts/sum(counts) , 'k' );
%   bar( Jbins , counts, 'k' );
 xlim( [ Jmin Jmax ] );
 xlabel( 'Jx' ); ylabel( 'p( J)' );
  figure( 3 ); 
 clf;
 subplot( 3,1,1 );
 nbins = 100;                                           %横坐标的间隔 
 timebins = linspace( timemin , timemax , nbins );
 counts = hist( time_record , timebins );
   bar( timebins , counts/sum(counts) , 'k' );
%    bar( timebins , counts, 'k' );
 xlim( [ timemin timemax ] );
 xlabel( 'time（min）' ); ylabel( 'p(time)' );

figure(4); 
plot(M_record)   
figure(5);                                                                   %轨迹图
plot(time_record)
figure(6); 
plot(J_record)



