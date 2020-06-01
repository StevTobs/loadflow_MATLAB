function [Y_bus, Theta] = Get_Ybus(  Line_set )

n_iter = size(Line_set,1);
dmm_line = Line_set;
for i = 1: n_iter
    for j = 1 : n_iter
        
        if i == dmm_line(j,1) 
            
            row = dmm_line( j,1 );
            col = dmm_line( j,2 );
            a =  dmm_line(j,3);
            b = dmm_line( j,4 );
            
            load_line = complex(a,b);
            y_dmm = inv(load_line);
          
            Y_bus( row , col) = - y_dmm  ;
            Theta( row , col) = angle( - y_dmm );
            Y_bus( col , row ) = - y_dmm ;
            Theta( col , row) = angle(- y_dmm) ;
     
        end        
    end
end
% abs( triu(Y_bus) )
%Sum in each row
sum_row = sum( (-Y_bus),1 );
%Diagonal Matrix
for i = 1 : n_iter
    Y_bus( i,i) = sum_row (i);
    Theta(i,i) = angle(sum_row (i)) ;
    
end

end
