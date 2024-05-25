fileID = fopen('input_network.txt','r');
formatSpec = '%f';
Input = fscanf(fileID,formatSpec); % Input about relevant info read % 
fclose(fileID);

Node = Input(1); % get number of nodes *
Packet_size = Input(2) * 8; % get the packet size in bits % 
T = Input(3) * 10^-3; % get simulation time in s %
Backoff_St = Input(4); % get the random backoff strategy %
utilities1 = [];
utilities2 = [];
utilities3 = [];
utilities4 = [];
utilities5 = [];
segment_size = Node;
for N = 1:Node
    for Backoff_StLoop = 1:Backoff_St
        if Backoff_StLoop == 1
        % Strategy 1 %
            total_time = 0;
            count = 0;
            good_time = 0;
            data_rate = 6 * 10^6; % 6 Mbps %
            packet_time = Packet_size / data_rate; % get packet time %
            slot_size = 9 * (10^-6); % 9 us %
            j = 1;
            simulation_count = 0;
            CW_min = 15;
            CW = 15;
            collision_flag = 0;
            r = (randi([0,CW_min],N,1)) * 10^-6; % generate N random numbers and put them into an array %
           
            while total_time < T
                
                [M,I] = min(r); % find the node with the minimum counter and index of node %
                simulation_count = simulation_count + 1;
                
                for i = 1:N   % check if there are more than one nodes with same minimum counter %
                    if (M == r(i))
                        count = count + 1;
                        collision_index(j) = i;
                        j = j + 1;
                    end
                end
                
                if count > 1
                    collision_flag = 1; % collision occured %
                end
                
                if collision_flag ~= 1 % if no collision, increase good time %
                    good_time = good_time + packet_time;
                    CW = CW_min;
                    r(I) = (randi([0,CW],1,1)) * 10^-6;
                else
                    CW = CW * 2;
                    for i = 1:N
                        if (M == r(i)) % for all nodes that collided, choose new rand %
                            r(i) = (randi([0,CW],1,1)) * 10^-6;
                        end
                    end
                end
                
                total_time = total_time + packet_time;
                
                for i = 1:N
                    for j = 1:size(collision_index)
                        if(i ~= collision_index(j))
                            r(i) = r(i) - slot_size;
                        end
                    end
                end
                count = 0;
                collision_flag = 0;
            end
            utility1 = good_time / total_time;
            utilities1 = [utilities1, utility1];
        end
        
        if Backoff_StLoop == 2
          % Strategy 2 %
            total_time = 0;
            count = 0;
            good_time = 0;
            data_rate = 6 * 10^6; % 6 Mbps %
            packet_time = Packet_size / data_rate; % get packet time %
            slot_size = 9 * (10^-6); % 9 us %
            j = 1;
            simulation_count = 0;
            CW_min = 15;
            CW = 15;
            collision_flag = 0;
            r = (randi([0,CW_min],N,1)) * 10^-6; % generate N random numbers and put them into an array %
           
            while total_time < T
                
                [M,I] = min(r); % find the node with the minimum counter and index of node %
                simulation_count = simulation_count + 1;
                
                for i = 1:N   % check if there are more than one nodes with same minimum counter %
                    if (M == r(i))
                        count = count + 1;
                        collision_index(j) = i;
                        j = j + 1;
                    end
                end
                
                if count > 1
                    collision_flag = 1; % collision occured %
                end
                
                if collision_flag ~= 1
                    good_time = good_time + packet_time;
                    CW = round(CW,2);
                    r(I) = (randi([0,CW],1,1)) * 10^-6;
                else
                    CW = CW + 2;
                    for i = 1:N
                        if (M == r(i))
                            r(i) = (randi([0,CW],1,1)) * 10^-6;
                        end
                    end
                end
                
                total_time = total_time + packet_time;
                for i = 1:N
                    for j = 1:size(collision_index)
                        if(i ~= collision_index(j))
                            r(i) = r(i) - slot_size;
                        end
                    end
                end
                count = 0;
                collision_flag = 0;
            end
            
            utility2 = good_time / total_time;
            utilities2 = [utilities2, utility2];
        end
        
        if Backoff_StLoop == 3
           % Strategy 3 %
            total_time = 0;
            count = 0;
            good_time = 0;
            data_rate = 6 * 10^6; % 6 Mbps %
            packet_time = Packet_size / data_rate; % get packet time %
            slot_size = 9 * (10^-6); % 9 us %
            j = 1;
            simulation_count = 0;
            CW_min = 15;
            CW = 15;
            collision_flag = 0;
            r = (randi([0,CW_min],N,1)) * 10^-6; % generate N random numbers and put them into an array %
           
            while total_time < T
                
                [M,I] = min(r); % find the node with the minimum counter and index of node %
                simulation_count = simulation_count + 1;
                
                for i = 1:N   % check if there are more than one nodes with same minimum counter %
                    if (M == r(i))
                        count = count + 1;
                        collision_index(j) = i;
                        j = j + 1;
                    end
                end
                
                if count > 1
                    collision_flag = 1; % collision occured %
                end
                
                if collision_flag ~= 1
                    good_time = good_time + packet_time;
                    CW = round(CW,2);
                    r(I) = (randi([0,CW],1,1)) * 10^-6;
                else
                    CW = CW * 2;
                    for i = 1:N
                        if (M == r(i))
                            r(i) = (randi([0,CW],1,1)) * 10^-6;
                        end
                    end
                end
                
                total_time = total_time + packet_time;
                for i = 1:N
                    for j = 1:size(collision_index)
                        if(i ~= collision_index(j))
                            r(i) = r(i) - slot_size;
                        end
                    end
                end
                count = 0;
                collision_flag = 0;
            end            
            utility3 = good_time / total_time;
            utilities3 = [utilities3, utility3];
        end
        
        if Backoff_StLoop == 4
        % Strategy 4 %
            total_time = 0;
            count = 0;
            good_time = 0;
            data_rate = 6 * 10^6; % 6 Mbps %
            packet_time = Packet_size / data_rate; % get packet time %
            slot_size = 9 * (10^-6); % 9 us %
            j = 1;
            simulation_count = 0;
            CW_min = 15;
            CW = 15;
            collision_flag = 0;
            r = (randi([0,CW_min],N,1)) * 10^-6; % generate N random numbers and put them into an array %
           
            while total_time < T
                
                [M,I] = min(r); % find the node with the minimum counter and index of node %
                simulation_count = simulation_count + 1;
                
                for i = 1:N   % check if there are more than one nodes with same minimum counter %
                    if (M == r(i))
                        count = count + 1;
                        collision_index(j) = i;
                        j = j + 1;
                    end
                end
                
                if count > 1
                    collision_flag = 1; % collision occured %
                end
                
                if collision_flag ~= 1
                    good_time = good_time + packet_time;
                    CW = CW - 2;
                    if CW < 1
                        CW = 2;
                    end
                    r(I) = (randi([0,CW],1,1)) * 10^-6;
                else
                    CW = CW + 2;
                    for i = 1:N
                        if (M == r(i))
                            r(i) = (randi([0,CW],1,1)) * 10^-6;
                        end
                    end
                end
                
                total_time = total_time + packet_time;
                for i = 1:N
                    for j = 1:size(collision_index)
                        if(i ~= collision_index(j))
                            r(i) = r(i) - slot_size;
                        end
                    end
                end
                count = 0;
                collision_flag = 0;
            end
            
            utility4 = good_time / total_time;
            utilities4 = [utilities4, utility4];
        end
        
        if Backoff_StLoop == 5
            % strategy 5 %
            total_time = 0;
            count = 0;
            good_time = 0;
            data_rate = 6 * 10^6; % 6 Mbps %
            packet_time = Packet_size / data_rate; % get packet time %
            slot_size = 9 * (10^-6); % 9 us %
            j = 1;
            simulation_count = 0;
            CW_min = 15;
            CW = 15;
            collision_flag = 0;
            r = (randi([0,CW_min],N,1)) * 10^-6; % generate N random numbers and put them into an array %
           
            while total_time < T
                
                [M,I] = min(r); % find the node with the minimum counter and index of node %
                simulation_count = simulation_count + 1;
                
                for i = 1:N   % check if there are more than one nodes with same minimum counter %
                    if (M == r(i))
                        count = count + 1;
                        collision_index(j) = i;
                        j = j + 1;
                    end
                end
                
                if count > 1
                    collision_flag = 1; % collision occured %
                end
                
                if collision_flag ~= 1
                    good_time = good_time + packet_time;
                    CW = CW - 2;
                    if CW < 1
                        CW = 2;
                    end
                    r(I) = (randi([0,CW],1,1)) * 10^-6;
                else
                    CW = CW * 2;
                    for i = 1:N
                        if (M == r(i))
                            r(i) = (randi([0,CW],1,1)) * 10^-6;
                        end
                    end
                end
                
                total_time = total_time + packet_time;
                for i = 1:N
                    for j = 1:size(collision_index)
                        if(i ~= collision_index(j))
                            r(i) = r(i) - slot_size;
                        end
                    end
                end
                count = 0;
                collision_flag = 0;
            end
            
            utility5 = good_time / total_time;
            utilities5 = [utilities5, utility5];
        end

        fprintf('Number of Nodes: %d ; Packet Size: %d ; Simulation Time(s): %d ; Backoff Strategy: %d \n Utilization: ', N, Input(2), T, Backoff_StLoop);
    end
end
figure; % Create new figure
hold on; % Hold on for multiple plots

plot(1:Node, utilities1)
plot(1:Node, utilities2)
plot(1:Node, utilities3)
plot(1:Node, utilities4)
plot(1:Node, utilities5)

xlabel('Nodes');
ylabel('Utilities');
title('Utilities with random backoff');
legend('Strategy 1', 'Strategy 2', 'Strategy 3', 'Strategy 4', 'Strategy 5');

avg_utility1 = mean(utilities1);
avg_utility2 = mean(utilities2);
avg_utility3 = mean(utilities3);
avg_utility4 = mean(utilities4);
avg_utility5 = mean(utilities5);

% Get the color of each plot
colors = get(gca, 'ColorOrder');

text(1, 0.86, sprintf('Avg Ultity 1: %.2f', avg_utility1), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', colors(1,:));
text(1, 0.88, sprintf('Avg Ultity 2: %.2f', avg_utility2), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', colors(2,:));
text(1, 0.90, sprintf('Avg Ultity 3: %.2f', avg_utility3), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', colors(3,:));
text(1, 0.92, sprintf('Avg Ultity 4: %.2f', avg_utility4), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', colors(4,:));
text(1, 0.94, sprintf('Avg Ultity 5: %.2f', avg_utility5), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', colors(5,:));


% Tìm chiến lược có hiệu suất tốt nhất
[best_utility, best_strategy] = max([avg_utility1, avg_utility2, avg_utility3, avg_utility4, avg_utility5]);

% In ra kết quả
fprintf('Chiến lược %d đạt hiệu suất tốt nhất với giá trị utility trung bình là %.2f\n', best_strategy, best_utility);
hold off; % Release hold for further plots