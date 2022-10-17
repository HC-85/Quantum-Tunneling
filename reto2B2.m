clear
h = .05; %Se define la discretizacion
X = -5:h:5; %Se define el dominio 
psi0 = ((10/pi).^.25)*exp(-5*(X + 3).^2 + 1i*25*X); %Se define la condicion inicial normalizada
D2 = (diag(ones(1,length(psi0)-1),1) + ...
    diag(-2*ones(1,length(psi0)),0)+ ...
    diag(ones(1,length(psi0)-1),-1))/(h^2); %Se define la matriz de segunda derivada
pot = 500; %Se utiliza un potencial de 500
V = diag([zeros(1,99), pot*ones(1,3), zeros(1,99)],0); %Se define la matriz del potencial
H = -D2/2 + V; %Se define la matriz del hamiltoniano
E = @(t) expm(-1i*t*H); %Se define el operador de evolucion
for k = 0:.005:.5 %El tiempo va de 0 a .5 segundos
    plot(X,abs(E(k)*psi0.').^2) %Se plotea el cuadrado del valor absoluto para obtener la onda de probabilidad
    hold on
    xline(-.05); %Se plotea la barrera de potencial
    xline(.05);
    hold off
    axis([-5,5,0,1.8]); 
    drawnow
end
a = (abs(E(.28)*psi0.').^2); %Obtenemos la onda de probabilidad para t=.28
sum(a(1:99))*h %Total de probabilidad antes del potencial
sum(a(103:end))*h %Total de probabilidad despues del potencial
sum(a)*h %Se conserva la norma de 1