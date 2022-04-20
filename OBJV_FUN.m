function [objvN] =OBJV_FUN(phen);
sizphen=size(phen); 
objvN=[];
    for j=1:sizphen(1)
fopen('PERMX.GRDECL','r');
%fopen('PERMY.GRDECL','r');
fopen('PERMZ.GRDECL','r');
permx=imp_file('PERMX.GRDECL');
%permy=textread('PERMY.GRDECL');
permz=imp_file('PERMZ.GRDECL');
permxphen=permx*phen(j,1);
%permyphen=permy*phen(j,1);
permzphen=permz*phen(j,2);
fid1=fopen('SAEIDI_PERMX.GRDECL','w');
fprintf(fid1,'PERMX \n');
fprintf(fid1,'%d\n',permxphen);
fprintf(fid1,'/\n');
fid2=fopen('SAEIDI_PERMY.GRDECL','w');
fprintf(fid2,'PERMY \n');
fprintf(fid2,'%d\n',permxphen);
fprintf(fid2,'/\n');
fid3=fopen('SAEIDI_PERMZ.GRDECL','w');
fprintf(fid3,'PERMZ \n');
fprintf(fid3,'%d\n',permzphen);
fprintf(fid3,'/\n');
%fprintf(fid1,'WCONINJE\n');
%fprintf(fid1,'I1 GAS OPEN RESV 1* %d /\n',phen(j,2));
%fprintf(fid1,'/\n');
%fid2=fopen('WPIMULT.m','w');
%fprintf(fid2,'WPIMULT\n');
%fprintf(fid2,'P1 %d/\n',phen(j,2));
%fprintf(fid2,'/\n');
%fid3=fopen('TCRIT.m','w');
%fprintf(fid3,'TCRIT\n');
%fprintf(fid3,'547.560\n734.580\n765.360\n828.720\n845.280\n913.320\n%d\n',phen(j,2));
%fprintf(fid3,'%d\n',phen(j,3));
%fprintf(fid3,'/\n');
%fid4=fopen('PCRIT.m','w');
%fprintf(fid4,'PCRIT\n');
%fprintf(fid4,'1069.8675\n529.0555\n551.0992\n490.8457\n489.3761\n430.5922\n%d\n',phen(j,4));
%fprintf(fid4,'%d\n',phen(j,5));
%fprintf(fid4,'/\n');
fclose('all');
[STATUS RESULTS]=dos('$e300 SAEIDI_FINAL')

%----------------------------- reading RSM file ---------------------------

fou=fopen('SAEIDI_FINAL.RSM','r');
[z1,z2,z3,z4,z5,z6,z7,z8,Z9,Z10]=textread('SAEIDI_FINAL.RSM','%f%f%f%f%f%f%f%f%f%f','headerlines',6);
prodhist=xlsread('production_history');
cofmat=polyfit(prodhist(:,1),prodhist(:,2),9);
simsize=size(z1);
err=0
for j=1:simsize
    err=err+abs(z6(j)-polyval(cofmat,z1(j)))
end
plot(z1,polyval(cofmat,z1))
hold on
plot(prodhist(:,1),prodhist(:,2),'--rs','LineWidth',1,...
    'markerEdgeColor','K',...
    'MarkerFaceColor','g',...
    'MarkerSize',3 )

plot(z1,z6)
fclose(fou);
objv=err
%-------------------------------------------------------------------------
     objvN=[objvN;objv];
     %clear z1 z2 z3 z4 z5 z6 z7   
    end      
end

