close all;
clear all;

% Generate sphere data
[x, y, z] = sphere(25);
h = surf(x, y, z);
axis equal;
%shading ;
h.FaceAlpha = 0.20;
h.LineStyle = ":";

 
line([-1,1], [0,0], [0,0], 'LineWidth' , 1, 'Color', [0 0 0])
line([0,0], [-1,1], [0,0], 'LineWidth' , 1, 'Color', [0 0 0])
line([0,0], [0,0], [-1,1], 'LineWidth' , 1, 'Color', [0 0 0])

text(0, 0, 1.1, '|RCP⟩', 'Interpreter', 'tex', 'FontSize', 12, 'HorizontalAlignment', 'Center')
text(0, 0, -1.1, '|LCP⟩', 'Interpreter', 'tex', 'FontSize', 12, 'HorizontalAlignment', 'Center')
text(1.1, 0, 0, '|D⟩', 'Interpreter', 'tex', 'FontSize', 12, 'HorizontalAlignment', 'Center')
text(0, 1.1, 0, '|V⟩', 'Interpreter', 'tex', 'FontSize', 12, 'HorizontalAlignment', 'Center')
text(-1.1, 0, 0, '|A⟩', 'Interpreter', 'tex', 'FontSize', 12, 'HorizontalAlignment', 'Center')
text(0, -1.1, 0, '|H⟩', 'Interpreter', 'tex', 'FontSize', 12, 'HorizontalAlignment', 'Center')

view(60, 15);
grid on;
axis on;
set(gca, 'FontSize', 10, 'FontWeight', 'bold', 'LineWidth', 1.5);
grid on;
set(gca, 'GridLineStyle', '--')
set(gca, 'GridAlpha', 0.25);
