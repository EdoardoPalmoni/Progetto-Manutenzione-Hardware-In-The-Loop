function out = matrix2latex_parameterstable(T_mean,T_std,row_values,col_values)

n_rows = size(T_mean,1);
n_cols = size(T_mean,2);

n_digits = 2;   % Number of decimal digits

out = "";
out = out + "\begin{tabular}{"+ repetestring("l",n_cols+1) + "} \hline" + newline;
for i = 1:n_rows+1
    for j = 1:n_cols+1

        % Column header
        if (i==1) && (j>=2)
            value = col_values(j-1);
            if value == 1
                out = out + "$J=\hat{J}$";
            else
                out = out + "$J=" + num2str(value) + "\>\hat{J}$";
            end
        end
        
        % Row header
        if (j==1) && (i>=2)
            value = row_values(i-1);
            if value == 1
                out = out + "$m=\hat{m}$";
            else
                out = out + "$m=" + num2str(row_values(i-1)) + "\>\hat{m}$";
            end
        end
        
        % Add table cells contents (mean \pm std)
        if (i>=2) && (j>=2)
            mean_number = round(T_mean(i-1,j-1),n_digits);
            std_number = round(T_std(i-1,j-1),n_digits);
            out = out + " $" + num2str(mean_number) + " \pm " + num2str(std_number) + "$ ";
        end

        % Add column separator and new line
        if j<n_cols+1
            out = out + " & ";
        elseif (j==n_cols+1) && (i==1)
            out = out + "\\ \hline" + newline;
        elseif (j==n_cols+1) && (i==n_rows+1)
            out = out + "\\ \hline" + newline;
        else
            out = out + "\\" + newline;
        end

    end
end

out = out + "\end{tabular}";

clipboard('copy', out);
disp("Latex tabular copied to clipboard");

end


function out = repetestring(string,n)
out = "";
for i = 1:n
    out = out + string;
end
end

