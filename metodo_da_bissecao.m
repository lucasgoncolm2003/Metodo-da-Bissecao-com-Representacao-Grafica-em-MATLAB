clc
format long
% Ingresso de Dados do Problema
Exp = input('Digite a função f(x) = ','s');
funcion = inline(Exp,'x');
a = input('Digite o extremo esquerdo do intervalo: ');
b = input('Digite o extremo direito do intervalo: ');
tol = input('Digite o valor do erro: ');

% Método da Bisseção
i = 1;
p(1) = 0;
a(i) = a;
b(i) = b;
fa(i) = funcion(a(i));
fb(i) = funcion(b(i));
while (abs(b(i) - a(i))>tol)
    if (fa(i)*fb(i)==0)
        if(fa(i)==0)
            p(i)=a(i);
            break
        else
            p(i)=b(i);
            break
        end
    elseif (funcion(a(i))*funcion(b(i))>0)
    error('A função não tem raízes no intervalo')
    else
        p(i)=(a(i)+b(i))/2;
        fp(i)=funcion(p(i));
        if(fp(i)==0)
            fprintf('A aproximação da raiz é p = %12.12f\n ',p(i))
            break
        elseif (fa(i)*fp(i)>0)
        a(i+1)=p(i);
        b(i+1)=b(i);
        fa(i+1)=fp(i);
        fb(i+1)=fb(i);
        i=i+1;
        else
            a(i+1)=a(i);
            b(i+1)=p(i);
            fa(i+1)=fa(i);
            fb(i+1)=fp(i);
            i=i+1;
        end
    end
end

% Elaboração de Tabela para Registro:

fprintf('|      n      |      a_n      |      b_n      |      p_n      |      f(a_n)      |      f(b_n)      |      f(p_n)      |      |p_n+1 - p_n|      |\n');
N=length(p);
for s=1:N
    if (s==1)
        erro(s)=0;
    else
        erro(s)=abs(p(s)-p(s-1));
    end
end
for j=1:N
    fprintf('|    %4.0f      | %12.12f | %12.12f | %12.12f | %12.12f | %12.12f | %12.12f | %12.12f \n', j, a(j), b(j), p(j), fa(j), fb(j), fp(j), erro(j))
end
fprintf('A aproximação da raiz é p = %12.12f\n ', p(N));

% Elaboração dos Gráficos
z = a:0.01:b;
hold on;
plot(z, funcion(z), "r", 'LineWidth', 2)
plot(p, funcion(p), "ko", 'LineWidth', 2)
yline(0);
xline(0);
hold off;
title("Gráfico de y="+Exp)
xlabel("Eixo x");
ylabel("Eixo y");
legend("y="+Exp,'y_n=f (p_n)',"y' = 0", "x' = 0");