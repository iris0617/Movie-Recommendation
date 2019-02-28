function [Pr_pos, Pr_neg, Pr_bnd, accuracy, generality] = accuracy_calculations(alpha, beta, P_C_X, P_X, a)                

Pr_pos = 0;
Pr_neg = 0;
Pr_bnd = 0;
Pr_A_pos = 0;
Pr_A_neg = 0;
Pr_A_bnd = 0;

    for i=1: length(P_C_X)
    
        if P_C_X(a,i) >= alpha
            Pr_pos = Pr_pos + P_X(i);                    
            Pr_A_pos  = Pr_A_pos + (P_C_X(a,i) * P_X(i));

        end
        
        if P_C_X(a,i) < alpha &&  P_C_X(a,i) > beta
            Pr_bnd = Pr_bnd + P_X(i);
            Pr_A_bnd  = Pr_A_bnd + (P_C_X(a,i) * P_X(i));
        end
        
        if P_C_X(a,i) <= beta
            Pr_neg = Pr_neg + P_X(i);
            Pr_A_neg  = Pr_A_neg + ((1-P_C_X(a,i)) * P_X(i));
        end
    end
    
   accuracy = (Pr_A_pos +Pr_A_neg) / (Pr_pos + Pr_neg);
   generality = (Pr_pos + Pr_neg);
    
    
end
                