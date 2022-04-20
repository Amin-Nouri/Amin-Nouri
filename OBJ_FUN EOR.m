function [objvN] =OBJV_FUN(phen);
sizphen=size(phen);
objvN=[];
for j=1:sizphen(1)
fid1=fopen('SMALL_MODEL_SCH_WCONPROD.INC','w');
fprintf(fid1,'WCONPROD\n 2 OPEN ORAT %d / \n 5 OPEN ORAT %d /n/',phen(j,1),phen(j,1));
fid2=fopen('SMALL_MODEL_SCH_GECON.INC','w');
fprintf(fid2,'GECON\n FIELD 3* %d 1* CON/\n/',phen(j,2));
%fid2=fopen('SMALL_MODEL_SCH_WCONINJE.INC','w');
%fprintf(fid1,'WCONINJE\n I1 GAS OPEN BHP 2*%d/\n 12 GAS OPEN BHP 2*%d/n 13 GAS OPEN BHP
2*%d/n 14 GAS OPEN BHP 2*%d/\n 15 GAS OPEN BHP 2*%d/\n 16 GAS OPEN BHP 2*%d
\n/',phen(j,2),phen(j,2),phen(j,2),phen(j,2),phen(j,2),phen(j,2));
fclose('all');
%[STATUS RESULTS]=dos('Se300 SMALL_MODEL_PREDICTION')
%--reading RSM file--
fou=fopen('SMALL_MODEL_PREDICTION.RSM','r');
[z1,z2,z3,z4,z5,z6,z7,z8,z9,z10]=textread('SMALL_MODEL_PREDICTION.RSM','%f%f%f%f%f%f%f%f%f%f',' headerlines',6);
capex=(-0.005*(max(z4)/1000)^2+0.997*max(z4)/1000)*10^6+((max(z5))/0.1*(-
0.005*((max(z4))/1000)^2+0.997*max(z4)/1000))*10^6+(3.9087*log((max(z6)/1000))+0.7462)*10^6+(m ax(z6)/1000)*10^6+11874+32800*(5.78*(max(z6)/1000)^0.5189+19.653*(max(z6)/1000)^0.301)+6*900 0000;
Nprime=size(z2);
N=Nprime(1);
opex(530)=0;
npv(530)=-capex;
for j=531:N
opex(j)=(capex*0.05)*(1.1*(z2(j)-z2(j-1)))^(z2(j)-36);
cashflow(j)=(z3(j)-z3(j-1))*80+(z10(j)-z10(j-1))*5+(z8(j)-z8(j-1))*20*0.056-opex(j);
npv(j)=cashflow(j)/1.05^(z2(j)-36);
end
cumnpv=sum(npv);
fclose(fou);
objv=cumnpv;
%------------------------------
objvN=[objvN;objv];
%clear z1 z2 z3 z4 z5 z6 z7
end
end
