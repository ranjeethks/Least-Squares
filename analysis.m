function analysis(run)

% Ranjeeth KS, University of Calgary, Canada

epochs = 4295;

fid = fopen('D:\Study\ENGO 620\Lab\codes\residue_1_w.dat');
residue_out = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid)

x_axis = 0:(epochs-1);


fid = fopen('D:\Study\ENGO 620\Lab\codes\residue_6_nw.dat');
residue_out2 = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid)

figure(1);
subplot(2,1,1)
plot(x_axis,residue_out{1,21}(:),'b');hold on;
plot(x_axis,residue_out2{1,21}(:),'k');hold on;
xlabel('time [s]');
ylabel('residue [m]');
title('PRN 28 residue');
legend('Weighted R, \sigma^2 = 1','Constant R, \sigma^2 = 6');

subplot(2,1,2)
plot(x_axis,residue_out{1,15}(:),'r');hold on;
plot(x_axis,residue_out2{1,15}(:),'g');hold on;
xlabel('time [s]');
ylabel('residue [m]');
title('PRN 17 residue');
legend('Weighted R, \sigma^2 = 1','Constant R, \sigma^2 = 6');

figure;
subplot(2,1,1)
plot(x_axis,residue_out{1,7}(:),'k');hold on;
plot(x_axis,residue_out2{1,7}(:),'r');hold on;
xlabel('time [s]');
ylabel('residue [m]');
title('PRN 08 residue');
legend('Weighted R, \sigma^2 = 1','Constant R, \sigma^2 = 6');

subplot(2,1,2)
plot(x_axis,residue_out{1,10}(:),'m');hold on;
plot(x_axis,residue_out2{1,10}(:),'k');hold on;
xlabel('time [s]');
ylabel('residue [m]');
title('PRN 11 residue');
legend('Weighted R, \sigma^2 = 1','Constant R, \sigma^2 = 6');

% computing correlation coefficients..
 for k = 1:epochs
     %if(run(1).num_blunders(k)==0) %check if the solution in first run is from blunderless measurements
         sigmax1 = run(1).stdENU(k,1);
         sigmax2 = run(1).stdENU(k,2);
         state_corr_coeft(k,1)=run(1).co_var(k,1)/(sigmax1*sigmax2);
         
         sigmax1 = run(1).stdENU(k,1);
         sigmax2 = run(1).stdENU(k,3);
         state_corr_coeft(k,2)=run(1).co_var(k,2)/(sigmax1*sigmax2);
         
         sigmax1 = run(1).stdENU(k,1);
         sigmax2 = run(1).stdENU(k,4);
         state_corr_coeft(k,3)=run(1).co_var(k,3)/(sigmax1*sigmax2);
         
         sigmax1 = run(1).stdENU(k,2);
         sigmax2 = run(1).stdENU(k,3);
         state_corr_coeft(k,4)=run(1).co_var(k,4)/(sigmax1*sigmax2);
         
         sigmax1 = run(1).stdENU(k,2);
         sigmax2 = run(1).stdENU(k,4);
         state_corr_coeft(k,5)=run(1).co_var(k,5)/(sigmax1*sigmax2);
         
         sigmax1 = run(1).stdENU(k,3);
         sigmax2 = run(1).stdENU(k,4);
         state_corr_coeft(k,6)=run(1).co_var(k,6)/(sigmax1*sigmax2);
     
     %else
     %    state_corr_coeft(k,:)=NaN;
    %end
 end
 %%
%  figure;
%  x_axis = 1:epochs;
%  plot(x_axis, state_corr_coeft(:,1)); hold on;
%  plot(x_axis, state_corr_coeft(:,2),'r'); hold on;
%  plot(x_axis, state_corr_coeft(:,3),'g'); hold on;
%  plot(x_axis, state_corr_coeft(:,4),'k'); hold on;
%  plot(x_axis, state_corr_coeft(:,5),'m'); hold on;
%  plot(x_axis, state_corr_coeft(:,6),'c'); hold on;
 
 
 
 %%
 %DOP after rejecting blunders 
 for k = 1:epochs
     DOP_befor_rejection(k,:) = run(1).DOP(k,:);
     num_sats_bfr_rejection(k) = run(1).num_sats(k);
     if(run(1).num_blunders(k)==0) %check if the solution in first run is from blunderless measurements
         DOP_after_rejection(k,:) = run(1).DOP(k,:);  
         num_sats_aftr_rejection(k) = run(1).num_sats(k);
         
     elseif(run(2).num_blunders(k)==0) %If blunder in first run, check for blunder in next run
         DOP_after_rejection(k,:) = run(2).DOP(k,:);
         num_sats_aftr_rejection(k) = run(2).num_sats(k);
     end
     
     if(run(1).GTestFailepochs(k) == 1)
         GlobalTest_PassOrFail(k) = 0; % Fail
     else
         GlobalTest_PassOrFail(k) = 1; % Pass
     end
     
     if(run(1).num_blunders(k))
         LocalTest_PassOrFail(k) = 0; %Fail
     else
         LocalTest_PassOrFail(k) = 1; %Pass
     end
 end
 
  %% 
%   if(~(find(run(2).GTestFailepochs > 0)))
%       disp('No Global test fail in 2nd run');
%   end
%   
%   if(~(find(run(2).num_blunders > 0)))
%       disp('No local test fail in 2nd run');
%   end
% 
 figure;
 subplot(2,1,1)
  x_axis = 1:epochs;
 plot(x_axis, DOP_after_rejection(:,1),'b'); hold on;
 plot(x_axis, DOP_after_rejection(:,2),'r'); hold on;
 plot(x_axis, DOP_after_rejection(:,3),'g'); hold on;
 plot(x_axis, DOP_after_rejection(:,4),'m'); hold on;
 plot(x_axis, DOP_after_rejection(:,5),'k'); hold on;
 
%  plot(x_axis, DOP_befor_rejection(:,1),'r'); hold on;
%  plot(x_axis, DOP_befor_rejection(:,2),'g'); hold on;
%  plot(x_axis, DOP_befor_rejection(:,3),'m'); hold on;
%  plot(x_axis, DOP_befor_rejection(:,4),'k'); hold on;
%  plot(x_axis, DOP_befor_rejection(:,5),'b'); 
 
 subplot(2,1,2)
 plot(x_axis,num_sats_aftr_rejection); hold on;
 %plot(x_axis,num_sats_bfr_rejection,'r');
 
 %%
 %global test epoch plot
  x_axis = 1:epochs;
  figure;
  subplot(2,1,1)
  plot(x_axis, GlobalTest_PassOrFail,'b');
  
  subplot(2,1,2)
  plot(x_axis, LocalTest_PassOrFail,'b');
  
  
 %%
%  %Checkin weighting methods
  x_axis = 1:epochs;
figure;
 subplot(3,1,1)
 plot(x_axis,run(1).dENU(:,1),'b','LineWidth',2); hold on; 
 plot(x_axis,run(1).stdENU(:,1),'b','LineWidth',3); hold on;
 plot(x_axis,-run(1).stdENU(:,1),'b','LineWidth',3); hold on;
 
 
%  plot(x_axis,weighing(2).dENU(:,1),'r','LineWidth',2); hold on; 
%   plot(x_axis,weighing(2).stdENU(:,1),'r','LineWidth',3); 
%  plot(x_axis,-weighing(2).stdENU(:,1),'r','LineWidth',3); 
 %legend('\deltaE','\sigma_\delta_E','-\sigma_\delta_E: For const R,','\deltaE','\sigma_\delta_E','-\sigma_\delta_E: For weighted R,','fontweight','bold','fontsize',16);
 legend('\deltaE','\sigma_\delta_E','-\sigma_\delta_E','fontweight','bold','fontsize',16);
 
 subplot(3,1,2)
 plot(x_axis,run(1).dENU(:,2),'b','LineWidth',2); hold on; 
 plot(x_axis,run(1).stdENU(:,2),'b','LineWidth',3); hold on;
 plot(x_axis,-run(1).stdENU(:,2),'b','LineWidth',3); hold on;
 
%  plot(x_axis,weighing(2).dENU(:,2),'r','LineWidth',2); hold on; 
%   plot(x_axis,weighing(2).stdENU(:,2),'r','LineWidth',3); 
%  plot(x_axis,-weighing(2).stdENU(:,2),'r','LineWidth',3); 
 %legend('\deltaN','\sigma_\delta_N','-\sigma_\delta_N: For const R,','\deltaN','\sigma_\delta_N','-\sigma_\delta_N: For weighted R,','fontweight','bold','fontsize',16);
 legend('\deltaN','\sigma_\delta_N','-\sigma_\delta_N','fontweight','bold','fontsize',16);
 subplot(3,1,3)
 plot(x_axis,run(1).dENU(:,3),'b','LineWidth',2); hold on; 
 plot(x_axis,run(1).stdENU(:,3)+mean(run(1).dENU(:,3)),'b','LineWidth',3); hold on;
 plot(x_axis,-run(1).stdENU(:,3)+mean(run(1).dENU(:,3)),'b','LineWidth',3); hold on;
 
%  plot(x_axis,weighing(2).dENU(:,3),'r','LineWidth',2); hold on; 
%   plot(x_axis,weighing(2).stdENU(:,3)+mean(weighing(2).dENU(:,3)),'r','LineWidth',3); 
%  plot(x_axis,-weighing(2).stdENU(:,3)+mean(weighing(2).dENU(:,3)),'r','LineWidth',3);
 %legend('\deltaU','\sigma_\delta_U','-\sigma_\delta_U: For const R,','\deltaU','\sigma_\delta_U','-\sigma_\delta_U: For weighted R,','fontweight','bold','fontsize',16);
 legend('\deltaU','\sigma_\delta_U','-\sigma_\delta_U','fontweight','bold','fontsize',16);
 
%  figure;
%  subplot(2,3,1)
%  hist(weighing(1).dENU(:,1),100);
%  subplot(2,3,4) ;
%  hist(weighing(2).dENU(:,1),100);
%  
%  subplot(2,3,2)
%  hist(weighing(1).dENU(:,2),100);
%  subplot(2,3,5) ;
%  hist(weighing(2).dENU(:,2),100);
%  
%  subplot(2,3,3)
%  hist(weighing(1).dENU(:,3),100);
%  subplot(2,3,6) ;
%  hist(weighing(2).dENU(:,3),100);

 %%
  
  %%
  
 %%
 figure;
 x_axis = 0:epochs-1
%subplot(2,1,1)
plot(x_axis,MDBout(:,1),'b');hold on;
plot(x_axis,MDBout(:,2),'k');hold on;
plot(x_axis,MDBout(:,3),'b');hold on;
plot(x_axis,MDBout(:,4),'k');hold on;
plot(x_axis,MDBout(:,5),'b');hold on;
plot(x_axis,MDBout(:,6),'k');hold on;
plot(x_axis,MDBout(:,7),'b');hold on;
plot(x_axis,MDBout(:,8),'k');hold on;
xlabel('time [s]');
ylabel('MDB [m]');
title('MDB Sat set 1');
legend('PRN 02','PRN 03','PRN 04','PRN 05','PRN 06','PRN 07','PRN 08','PRN 09');

figure;
%subplot(2,1,1)
plot(x_axis,MDBout(:,9),'b');hold on;
plot(x_axis,MDBout(:,10),'k');hold on;
plot(x_axis,MDBout(:,11),'b');hold on;
plot(x_axis,MDBout(:,12),'k');hold on;
plot(x_axis,MDBout(:,13),'b');hold on;
plot(x_axis,MDBout(:,14),'k');hold on;
plot(x_axis,MDBout(:,15),'b');hold on;
plot(x_axis,MDBout(:,16),'k');hold on;
xlabel('time [s]');
ylabel('MDB [m]');
title('MDB Sat set 2');
legend('PRN 10','PRN 11','PRN 12','PRN 13','PRN 14','PRN 15','PRN 17','PRN 19');

figure;
%subplot(2,1,1)
plot(x_axis,MDBout(:,17),'b');hold on;
plot(x_axis,MDBout(:,18),'k');hold on;
plot(x_axis,MDBout(:,19),'b');hold on;
plot(x_axis,MDBout(:,20),'k');hold on;
plot(x_axis,MDBout(:,21),'b');hold on;
plot(x_axis,MDBout(:,22),'k');hold on;
plot(x_axis,MDBout(:,23),'b');hold on;

xlabel('time [s]');
ylabel('MDB [m]');
title('MDB Sat set 3');
legend('PRN 20','PRN 23','PRN 26','PRN 27','PRN 28','PRN 30','PRN 32');
  
  
%%

figure;

 x_axis = 0:epochs-1
%subplot(2,1,1)
plot(x_axis,dx_ext_relH(:,1),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,2),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,3),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,4),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,5),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,6),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,7),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,8),'k','LineWidth',2);hold on;
xlabel('time [s]','fontweight','bold','fontsize',16);
ylabel('Horizontal protection level [m]','fontweight','bold','fontsize',16);
title('External reliability Sat set 1','fontweight','bold','fontsize',16);
legend('PRN 02','PRN 03','PRN 04','PRN 05','PRN 06','PRN 07','PRN 08','PRN 09','fontsize',16);
grid on;
figure;

%subplot(2,1,1)
plot(x_axis,dx_ext_relH(:,9),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,10),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,11),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,12),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,13),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,14),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,15),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,16),'k','LineWidth',2);hold on;
xlabel('time [s]','fontweight','bold','fontsize',16);
ylabel('Horizontal protection level [m]','fontweight','bold','fontsize',16);
title('External reliability Sat set 2','fontweight','bold','fontsize',16);
legend('PRN 10','PRN 11','PRN 12','PRN 13','PRN 14','PRN 15','PRN 17','PRN 19','fontsize',16);
grid on;
figure;
grid on;
%subplot(2,1,1)
plot(x_axis,dx_ext_relH(:,17),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,18),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,19),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,20),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,21),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,22),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relH(:,23),'b','LineWidth',2);hold on;

xlabel('time [s]','fontweight','bold','fontsize',16);
ylabel('Horizontal protection level [m]','fontweight','bold','fontsize',16);
title('External reliability Sat set 3','fontweight','bold','fontsize',16);
legend('PRN 20','PRN 23','PRN 26','PRN 27','PRN 28','PRN 30','PRN 32','fontsize',16);
 grid on;
 %%
 figure;

 x_axis = 0:epochs-1
%subplot(2,1,1)
plot(x_axis,dx_ext_relV(:,1),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,2),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,3),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,4),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,5),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,6),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,7),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,8),'k','LineWidth',2);hold on;
xlabel('time [s]','fontweight','bold','fontsize',16);
ylabel('Vertical protection level [m]','fontweight','bold','fontsize',16);
title('External reliability Sat set 1','fontweight','bold','fontsize',16);
legend('PRN 02','PRN 03','PRN 04','PRN 05','PRN 06','PRN 07','PRN 08','PRN 09','fontsize',16);
grid on;
figure;

%subplot(2,1,1)
plot(x_axis,dx_ext_relV(:,9),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,10),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,11),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,12),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,13),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,14),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,15),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,16),'k','LineWidth',2);hold on;
xlabel('time [s]','fontweight','bold','fontsize',16);
ylabel('Vertical protection level [m]','fontweight','bold','fontsize',16);
title('External reliability Sat set 2','fontweight','bold','fontsize',16);
legend('PRN 10','PRN 11','PRN 12','PRN 13','PRN 14','PRN 15','PRN 17','PRN 19','fontsize',16);
grid on;
figure;
grid on;
%subplot(2,1,1)
plot(x_axis,dx_ext_relV(:,17),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,18),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,19),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,20),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,21),'b','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,22),'k','LineWidth',2);hold on;
plot(x_axis,dx_ext_relV(:,23),'b','LineWidth',2);hold on;

xlabel('time [s]','fontweight','bold','fontsize',16);
ylabel('Vertical protection level [m]','fontweight','bold','fontsize',16);
title('External reliability Sat set 3','fontweight','bold','fontsize',16);
legend('PRN 20','PRN 23','PRN 26','PRN 27','PRN 28','PRN 30','PRN 32','fontsize',16);
 grid on;


