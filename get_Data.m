function data = get_Data()

n = 100;
point = linspace(0, 2*pi,n);

%start position
data.start_center = [0 0];
data.start_radius = 0.05;
data.startx = data.start_radius * cos(point) + data.start_center(1);
data.starty = data.start_radius * sin(point) + data.start_center(2);


%end position
data.end_center = [10 0];
data.end_radius = 0.05;
data.endx = data.end_radius * cos(point) + data.end_center(1);
data.endy = data.end_radius * sin(point) + data.end_center(2);


%object
data.center = [5 0];
data.radius = 1;
data.x = data.radius * cos(point) + data.center(1);
data.y = data.radius * sin(point) + data.center(2);

% plot(data.startx,data.starty);
% hold on
% plot(data.endx, data.endy);
% hold on
% plot(data.x,data.y);



end

