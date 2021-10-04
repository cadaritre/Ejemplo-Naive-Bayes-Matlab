clc; clear all; close all;
load handel.mat
Fs = 44100;
nBits = 16;
nChannels = 1;

casa=[0.093087774	2154.630219	22436	0.012364211	0.001282678;
0.035253438	810.3815918	16000	0.006166924	0.000718909;
0.05130994	1032.500671	16926	0.006746276	0.000944449;
0.084164825	1558.694183	17246	0.013140365	0.001002985;
0.078026839	1355.325867	15249	0.012792493	0.001184067;
0.029302148	473.1703491	10861	0.007510708	0.000504272;
0.038330773	696.2648621	13833	0.005675258	0.000798617;
0.043747397	769.1417847	13496	0.005636082	0.000935916;
0.050678849	820.2800598	13581	0.006784015	0.000935278;
0.052753038	905.4272156	13485	0.007245419	0.000929059;];

gato=[0.066581675	1341.608765	19799	0.007368902	0.001336453
0.062620941	1095.748932	14926	0.006904502	0.001224332
0.067788836	1252.035492	17729	0.008229685	0.001155985
0.041168217	763.1381531	12807	0.00378287	0.000560064
0.070601865	1371.514404	17346	0.008013189	0.001051757
0.062741261	1149.993073	14924	0.006549974	0.000994954
0.061472459	1059.625824	15689	0.006616851	0.000989037
0.068326437	1225.954895	15037	0.00797991	0.001066224
0.064761263	1161.009979	16688	0.007904147	0.001032855
0.069440323	1156.32196	14533	0.008660855	0.001161895];

computadora=[0.0895686	2015.853027	20970	0.012947884	0.001964531
0.067543471	1434.478271	18424	0.008137026	0.001852904
0.076368241	1566.968781	19683	0.009756588	0.001825555
0.080010623	1705.658447	20011	0.010262348	0.002037628
0.052078694	1164.717102	20528	0.005233891	0.001633743
0.068629036	1444.885712	19896	0.007737032	0.00204945
0.064343805	1568.622192	20943	0.006375552	0.001918963
0.063899141	1679.254883	23267	0.005590803	0.001835582
0.069850454	1828.262909	23423	0.00686451	0.002034494
0.05061799	1286.860901	20964	0.003786134	0.001020576];

reloj=[0.092843512	1805.653961	18519	0.013115507	0.001346732
0.069023041	1405.961853	19376	0.00642856	0.000917538
0.058615575	1431.612701	19853	0.004635621	0.001411754
0.051769802	1151.250153	17618	0.003829106	0.001072424
0.061354951	1174.558228	15383	0.005255272	0.001173684
0.065998622	1321.697205	14804	0.00533515	0.000968287
0.087733136	1716.729675	15797	0.008521973	0.001380163
0.077856099	1554.27417	16893	0.006846894	0.001287721
0.083694783	1376.601898	13425	0.011070209	0.001129321
0.078448577	1695.470215	19087	0.00920824	0.000999193];



palabra = audiorecorder(Fs, nBits, nChannels);
disp('inicio');
recordblocking(palabra, 1);
disp('fin');

palabra=getaudiodata(palabra);
y = abs(palabra);

c = 0;
for i=1: length(y)
    if(y(i)>0.009)
        c=c+1;
        vector2(c)=y(i);
    end
end
if (c==0)
    vector2=zeros(1,10);
end
tabla(1,1) = std(y);
tabla(1,2) = sum(y);
c = 0;
for i=1: length(y)
    if (y(i)>0.009)
        c = c+1;
        vector2(i)=y(i);
    end
end
if (c==0)
    vector2 = zeros(1,10);
end
tabla(1,3) = c;
tabla(1,4)  =var(vector2);

Ft = (abs(fft(y))/(length(y)/2));
C_Frec = std(Ft(300:600));
tabla(1,5) = C_Frec;

%Algoritmo Naive Bayesiano
%palabra casa
a1 = var(casa(:,1));
a2 = mean(casa(:,1));
a3 = var(casa(:,2));
a4 = mean(casa(:,2));
a5= var(casa(:,3));
a6 = mean(casa(:,3));
a7= var(casa(:,4));
a8 = mean(casa(:,4));
a9 = var(casa(:,5));
a10 = mean(casa(:,5));

%palabra gato
b1 = var(gato(:,1));
b2 = mean(gato(:,1));
b3 = var(gato(:,2));
b4 = mean(gato(:,2));
b5= var(gato(:,3));
b6 = mean(gato(:,3));
b7= var(gato(:,4));
b8 = mean(gato(:,4));
b9 = var(gato(:,5));
b10 = mean(gato(:,5));

%palabra computadora
c1 = var(computadora(:,1));
c2 = mean(computadora(:,1));
c3 = var(computadora(:,2));
c4 = mean(computadora(:,2));
c5= var(computadora(:,3));
c6 = mean(computadora(:,3));
c7= var(computadora(:,4));
c8 = mean(computadora(:,4));
c9 = var(computadora(:,5));
c10 = mean(computadora(:,5));

%palabra reloj
d1 = var(reloj(:,1));
d2 = mean(reloj(:,1));
d3 = var(reloj(:,2));
d4 = mean(reloj(:,2));
d5= var(reloj(:,3));
d6 = mean(reloj(:,3));
d7= var(reloj(:,4));
d8 = mean(reloj(:,4));
d9 = var(reloj(:,5));
d10 = mean(reloj(:,5));

valor1 = tabla(1,1);
valor2 = tabla(1,2);
valor3 = tabla(1,3);
valor4 = tabla(1,4);
valor5 = tabla(1,5);

conjunto  = [a1 a2 	a3	a4	a5	a6	a7	a8	a9	a10
b1	b2	b3	b4	b5	b6	b7	b8	b9	b10
c1	c2	c3	c4	c5	c6	c7	c8	c9	c10
d1	d2	d3	d4	d5	d6	d7	d8	d9	d10
];
Pcasa = 0.25;
Pgato = 0.25;
Pcomputadora = 0.25;
Preloj = 0.25;

%Bayesiano
for j=1: 4
 
    for i=1: 5         
        if i == 1
            ecuacion = 1/sqrt(2*pi*conjunto(j,1))*exp((-1*(tabla(1,i)-...
            conjunto(j,2))^2)/(2*conjunto(j,1)));
            
        end
        if i == 2
            ecuacion = 1/sqrt(2*pi*conjunto(j,3))*exp((-1*(tabla(1,i)-...
            conjunto(j,4))^2)/(2*conjunto(j,3)));
            
        end  
        if i == 3
            ecuacion = 1/sqrt(2*pi*conjunto(j,5))*exp((-1*(tabla(1,i)-...
            conjunto(j,6))^2)/(2*conjunto(j,5)));
            
        end             
        if i == 4
            ecuacion = 1/sqrt(2*pi*conjunto(j,7))*exp((-1*(tabla(1,i)-...
            conjunto(j,8))^2)/(2*conjunto(j,7)));
            
        end     
        if i == 5
            ecuacion = 1/sqrt(2*pi*conjunto(j,9))*exp((-1*(tabla(1,i)-...
            conjunto(j,10))^2)/(2*conjunto(j,9)));
            
        end             
        valoref(j,i) = ecuacion;
    end
end


evidencia = 0.25*valoref(1,1)*valoref(1,2)*valoref(1,3)*valoref(1,4)*valoref(1,5)...
+ 0.25*valoref(2,1)*valoref(2,2)*valoref(2,3)*valoref(2,4)*valoref(2,5)...
+ 0.25*valoref(3,1)*valoref(3,2)*valoref(3,3)*valoref(3,4)*valoref(3,5)...
+ 0.25*valoref(4,1)*valoref(4,2)*valoref(4,3)*valoref(4,4)*valoref(4,5);

prioriticasa = 0.25*valoref(1,1)*valoref(1,2)*valoref(1,3)*valoref(1,4)*valoref(1,5);
prioritigato = 0.25*valoref(2,1)*valoref(2,2)*valoref(2,3)*valoref(2,4)*valoref(2,5);
prioriticomputadora = 0.25*valoref(3,1)*valoref(3,2)*valoref(3,3)*valoref(3,4)*valoref(3,5);
prioritireloj = 0.25*valoref(4,1)*valoref(4,2)*valoref(4,3)*valoref(4,4)*valoref(4,5);

posterioricasa = prioriticasa/evidencia;
posteriorigato = prioritigato/evidencia;
posterioricomputadora = prioriticomputadora/evidencia;
posteriorireloj = prioritireloj/evidencia;

disp(posterioricasa + "  Probabilidad de casa");
disp(posteriorigato + "  Probabilidad de gato");
disp(posterioricomputadora + "  Probabilidad de computadora");
disp(posteriorireloj+ "  Probabilidad de reloj");

% if (posterioricasa>posteriorigato) && (posterioricasa>posterioricomputadora) && (posterioricasa>posteriorireloj)
%     disp('La palabra es casa');
% else
% end
%     
% if (posteriorigato>posterioricasa) && (posteriorigato>posterioricomputadora) && (posteriorigato>posteriorireloj)
%         disp('La palabra es casa');
% else
% end
% 
% if (posterioricomputadora>posterioricasa) && (posterioricomputadora>posteriorigato) && (posterioricomputadora>posteriorireloj)
%     disp('La palabra es casa');
% else
% end
% 
% if (posteriorireloj>posterioricasa) && (posteriorireloj>posteriorigato) && (posteriorireloj>posterioricomputadora)
%         disp('La palabra es reloj');
%         else
% end
