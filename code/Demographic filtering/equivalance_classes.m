function eqv = equivalance_classes(data) 
[rows, col] = size(data);
eqv = zeros(rows,rows);
 
for i=1:rows
    eqv(i,1) = i;
     f = 2;
     for j=1:rows
         if i ==j
             continue;
         else         
             
             if isequal(data(i,:),data(j,:)) == 1
             eqv(i,f) = j;
             f = f+1;
             end 
         end 
     end 
 end 
         
 eqv = sort(eqv, 2);
 
eqv = unique(eqv, 'rows');

end 