clc, clear, close all;
% Load the MATLAB dataset
filenames={
'test_data20231030_163436.mat'                    
'test_data20231030_192836.mat'                        
'test_data20231030_204507.mat'                        
'test_data20231030_225338.mat'                        
'test_data20231101_005823.mat'                        
'test_data20231101_021843.mat'                        
'test_data20231101_125001.mat'                        
'test_data20231101_140715.mat'                        
'test_data20231101_155836.mat'
};
best_mincompliance= inf;
best_shape=[];

for fileno=1:length(filenames)
    filename=filenames{fileno};
    display(filename)
load(filename);  % Here loading test dataset from the filenames

% Find the minimum compliance value and its index
[min_compliance, min_index] = min(iteration_c);


% Display the minimum compliance value
disp(['Minimum compliance value: ', num2str(min_compliance)]);


% Display the corresponding design (x matrix) for the minimum compliance
min_design_matrix = iteration_x(:, :, min_index);
disp('Design for minimum compliance:');
% disp(min_design_matrix);
 iteration_vf = zeros(size(iteration_c));
for shapeno=1:length(iteration_c)
    iteration_vf(shapeno)=mean(mean(iteration_x(:,:,shapeno)));

end
volfrac = mean(mean(min_design_matrix));
if min_compliance <best_mincompliance
    best_mincompliance = min_compliance;
    best_design = min_design_matrix;
end

if 0
% Plot the design for the minimum compliance
figure;
colormap(gray); imagesc(1 - min_design_matrix); clim([0 1]); axis equal; axis off;
title('Design for Minimum Compliance');
end

figure(1)
hold on 
semilogy(iteration_vf,iteration_c,'.')
%plot(iteration_vf,iteration_c,'.')
xlabel('volfrac')
ylabel('compliance')
end

% Find points with compliance less than 10^6 and volume fraction less than 0.49
selected_points = find(iteration_c < 1e6 & iteration_vf < 0.486);

% Display the indices of selected points
disp('Indices of points with compliance < 1e6 and volfrac < 0.49:');
disp(selected_points);

% Extract compliance and volume fraction values for selected points
selected_compliance = iteration_c(selected_points);
selected_volfrac = iteration_vf(selected_points);

% Display the compliance and volume fraction values for selected points
disp('Compliance values for selected points:');
disp(selected_compliance);

disp('Volume fraction values for selected points:');
disp(selected_volfrac);
% Plot the graph with selected points
figure;
%semilogy(iteration_vf, iteration_c, '.');  % Plot all points
%hold on;
semilogy(selected_volfrac, selected_compliance, 'ro', 'MarkerSize', 10);  % Highlight selected points in red
xlabel('Volume Fraction');
ylabel('Compliance');
title('Compliance vs. Volume Fraction with Selected Points');
legend('All Points', 'Selected Points');
grid on;
hold off;

% Plot the design for the minimum compliance
figure;
colormap(gray); imagesc(1 - best_design); clim([0 1]); axis equal; axis off;
title(['Design for Minimum Compliance ' num2str(best_mincompliance)]);
%%
% Convert linear indices to subscripts (row and column indices)
[row_indices, col_indices] = ind2sub(size(iteration_x), selected_points);

% Plot the design for the minimum compliance with selected points
figure;
colormap(gray);
imagesc(1 - best_design);  % Plot the best design
hold on;
plot(col_indices, row_indices, 'ro', 'MarkerSize', 10);  % Highlight selected points in red
title(['Best Design with Selected Points (Compliance < 1e6 and Volfrac < 0.486)']);
axis equal;
axis off;
colorbar;
