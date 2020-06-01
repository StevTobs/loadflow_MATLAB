function [J] = calJacobian( P_unknown_index , Q_unknown_index, V_unknown_index, Yin, Tin, Pin, Qin, Din, Vin)

n_bus = size(P_unknown_index,2);

syms 'Y' [n_bus, n_bus]
syms 'T' [n_bus, n_bus]

syms 'P' [1, n_bus]
syms 'Q' [1, n_bus]
syms 'V' [1, n_bus]
syms 'D' [1, n_bus]

p_size = size(P,2)

for k = 2 : n_bus
        P(k) = 0;
        Q(k) = 0;
        for i = 1 : p_size
            P(k) = P(k) + Y(k,i)*V(i)*cos( (D(k) - D(i)) - T(k,i) );            
        
            Q(k) = Q(k) + Y(k,i)*V(i)*sin( (D(k) - D(i)) - T(k,i) ); 
        end
        
        Q(k)  = Q(k) * V(k);
        P(k)  = P(k) * V(k);
end

J1 = jacobian(P,D);
J3 = jacobian(Q,D);

J2 = jacobian(P,V);
J4 = jacobian(Q,V);


%Marking !!!!

for i = 1:n_bus
    if P_unknown_index (i)==0
        J1(i,:)=NaN;
        J1(:,i)=NaN;
        J3(:,i)=NaN;
        J2(i,:)=NaN;
    end
    
     if Q_unknown_index (i)==0
        J3(i,:)=NaN;
        J4(i,:)=NaN;
        
     end
     
     if V_unknown_index (i)==0
          J2(:,i)=NaN;
          J4(:,i)=NaN;
     end
end 


J1;
mark = not(isnan(J1));
dmm = zeros(sum(any(mark ,2)), sum(any(mark )));
J1 = reshape( J1(not(mark == 0)), [sum(any(mark ,2)), sum(any(mark ))]);

J2;
mark = not(isnan(J2));
dmm = zeros(sum(any(mark ,2)), sum(any(mark )));
J2 = reshape( J2(not(mark == 0)), [sum(any(mark ,2)), sum(any(mark ))]);

J3;
mark = not(isnan(J3));
dmm = zeros(sum(any(mark ,2)), sum(any(mark )));
J3 = reshape( J3(not(mark == 0)), [sum(any(mark ,2)), sum(any(mark ))]);

J4;
mark = not(isnan(J4));
dmm = zeros(sum(any(mark ,2)), sum(any(mark )));
J4 = reshape( J4(not(mark == 0)), [sum(any(mark ,2)), sum(any(mark ))]);



J1 = subs( subs( subs( subs(J1,V, Vin), Y, Yin), D, Din), T, Tin)
J2 = subs( subs( subs( subs(J2,V, Vin), Y, Yin), D, Din), T, Tin)
J3 = subs( subs( subs( subs(J3,V, Vin), Y, Yin), D, Din), T, Tin)
J4 = subs( subs( subs( subs(J4,V, Vin), Y, Yin), D, Din), T, Tin)


J = [J1 J2;J3 J4];


end



