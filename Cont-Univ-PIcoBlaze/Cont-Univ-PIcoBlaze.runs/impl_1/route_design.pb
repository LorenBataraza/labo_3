
?
Command: %s
53*	vivadotcl2
route_designZ4-113h px� 
~
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2
xc7s50Z17-347h px� 
n
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2
xc7s50Z17-349h px� 
^
,Running DRC as a precondition to command %s
22*	vivadotcl2
route_designZ4-22h px� 
>
Running DRC with %s threads
24*drc2
8Z23-27h px� 
D
DRC finished with %s
79*	vivadotcl2

0 ErrorsZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
D

Starting %s Task
103*constraints2	
RoutingZ18-103h px� 
k
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
8Z35-254h px� 
L

Phase %s%s
101*constraints2
1 2
Build RT DesignZ18-101h px� 
I
%s*common20
.Phase 1 Build RT Design | Checksum: 29c5383ff
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:13 ; elapsed = 00:00:11 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 914 ; free virtual = 6993h px� 
R

Phase %s%s
101*constraints2
2 2
Router InitializationZ18-101h px� 
W

Phase %s%s
101*constraints2
2.1 2
Fix Topology ConstraintsZ18-101h px� 
T
%s*common2;
9Phase 2.1 Fix Topology Constraints | Checksum: 29c5383ff
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:13 ; elapsed = 00:00:11 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 914 ; free virtual = 6993h px� 
P

Phase %s%s
101*constraints2
2.2 2
Pre Route CleanupZ18-101h px� 
M
%s*common24
2Phase 2.2 Pre Route Cleanup | Checksum: 29c5383ff
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:13 ; elapsed = 00:00:11 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 914 ; free virtual = 6993h px� 
L

Phase %s%s
101*constraints2
2.3 2
Update TimingZ18-101h px� 
I
%s*common20
.Phase 2.3 Update Timing | Checksum: 195492cc1
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:11 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 901 ; free virtual = 6980h px� 
y
Intermediate Timing Summary %s164*route28
6| WNS=2.285  | TNS=0.000  | WHS=-0.225 | THS=-11.806|
Z35-416h px� 
O
%s*common26
4Phase 2 Router Initialization | Checksum: 184137906
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 891 ; free virtual = 6970h px� 
K

Phase %s%s
101*constraints2
3 2
Global RoutingZ18-101h px� 
H
%s*common2/
-Phase 3 Global Routing | Checksum: 184137906
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 891 ; free virtual = 6970h px� 
L

Phase %s%s
101*constraints2
4 2
Initial RoutingZ18-101h px� 
W

Phase %s%s
101*constraints2
4.1 2
Initial Net Routing PassZ18-101h px� 
T
%s*common2;
9Phase 4.1 Initial Net Routing Pass | Checksum: 1c0c048e9
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
I
%s*common20
.Phase 4 Initial Routing | Checksum: 1c0c048e9
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
O

Phase %s%s
101*constraints2
5 2
Rip-up And RerouteZ18-101h px� 
Q

Phase %s%s
101*constraints2
5.1 2
Global Iteration 0Z18-101h px� 
y
Intermediate Timing Summary %s164*route28
6| WNS=1.857  | TNS=0.000  | WHS=N/A    | THS=N/A    |
Z35-416h px� 
N
%s*common25
3Phase 5.1 Global Iteration 0 | Checksum: 28e106a65
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
L
%s*common23
1Phase 5 Rip-up And Reroute | Checksum: 28e106a65
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
X

Phase %s%s
101*constraints2
6 2
Delay and Skew OptimizationZ18-101h px� 
L

Phase %s%s
101*constraints2
6.1 2
Delay CleanUpZ18-101h px� 
I
%s*common20
.Phase 6.1 Delay CleanUp | Checksum: 28e106a65
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
V

Phase %s%s
101*constraints2
6.2 2
Clock Skew OptimizationZ18-101h px� 
S
%s*common2:
8Phase 6.2 Clock Skew Optimization | Checksum: 28e106a65
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
U
%s*common2<
:Phase 6 Delay and Skew Optimization | Checksum: 28e106a65
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
J

Phase %s%s
101*constraints2
7 2
Post Hold FixZ18-101h px� 
L

Phase %s%s
101*constraints2
7.1 2
Hold Fix IterZ18-101h px� 
y
Intermediate Timing Summary %s164*route28
6| WNS=1.937  | TNS=0.000  | WHS=0.105  | THS=0.000  |
Z35-416h px� 
I
%s*common20
.Phase 7.1 Hold Fix Iter | Checksum: 2161ecd52
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
G
%s*common2.
,Phase 7 Post Hold Fix | Checksum: 2161ecd52
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
K

Phase %s%s
101*constraints2
8 2
Route finalizeZ18-101h px� 
H
%s*common2/
-Phase 8 Route finalize | Checksum: 2161ecd52
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 890 ; free virtual = 6969h px� 
R

Phase %s%s
101*constraints2
9 2
Verifying routed netsZ18-101h px� 
O
%s*common26
4Phase 9 Verifying routed nets | Checksum: 2161ecd52
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 889 ; free virtual = 6968h px� 
O

Phase %s%s
101*constraints2
10 2
Depositing RoutesZ18-101h px� 
L
%s*common23
1Phase 10 Depositing Routes | Checksum: 24b61a2ca
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 889 ; free virtual = 6968h px� 
R

Phase %s%s
101*constraints2
11 2
Post Process RoutingZ18-101h px� 
O
%s*common26
4Phase 11 Post Process Routing | Checksum: 24b61a2ca
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 889 ; free virtual = 6968h px� 
P

Phase %s%s
101*constraints2
12 2
Post Router TimingZ18-101h px� 
u
Estimated Timing Summary %s
57*route28
6| WNS=1.937  | TNS=0.000  | WHS=0.105  | THS=0.000  |
Z35-57h px� 
�
�The final timing numbers are based on the router estimated timing analysis. For a complete and accurate timing signoff, please run report_timing_summary.
127*routeZ35-327h px� 
M
%s*common24
2Phase 12 Post Router Timing | Checksum: 24b61a2ca
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 889 ; free virtual = 6968h px� 
Y

Phase %s%s
101*constraints2
13 2
Post-Route Event ProcessingZ18-101h px� 
U
%s*common2<
:Phase 13 Post-Route Event Processing | Checksum: 538c946c
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 889 ; free virtual = 6968h px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
D
%s*common2+
)Ending Routing Task | Checksum: 538c946c
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:12 . Memory (MB): peak = 2964.945 ; gain = 0.000 ; free physical = 889 ; free virtual = 6968h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 
~
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
932
02
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
route_designZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
route_design: 2

00:00:162

00:00:122

2964.9452
0.0002
8892
6968Z17-722h px� 
�
Executing command : %s
56330*	planAhead2�
�report_drc -file picoblaze_example_top_drc_routed.rpt -pb picoblaze_example_top_drc_routed.pb -rpx picoblaze_example_top_drc_routed.rpxZ12-24828h px� 
�
Command: %s
53*	vivadotcl2�
�report_drc -file picoblaze_example_top_drc_routed.rpt -pb picoblaze_example_top_drc_routed.pb -rpx picoblaze_example_top_drc_routed.rpxZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
>
Running DRC with %s threads
24*drc2
8Z23-27h px� 
�
#The results of DRC are in file %s.
586*	vivadotcl2�
f/home/lorenzo/Cont-Univ-PIcoBlaze/Cont-Univ-PIcoBlaze.runs/impl_1/picoblaze_example_top_drc_routed.rptf/home/lorenzo/Cont-Univ-PIcoBlaze/Cont-Univ-PIcoBlaze.runs/impl_1/picoblaze_example_top_drc_routed.rpt8Z2-168h px� 
J
%s completed successfully
29*	vivadotcl2

report_drcZ4-42h px� 
�
Executing command : %s
56330*	planAhead2�
�report_methodology -file picoblaze_example_top_methodology_drc_routed.rpt -pb picoblaze_example_top_methodology_drc_routed.pb -rpx picoblaze_example_top_methodology_drc_routed.rpxZ12-24828h px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file picoblaze_example_top_methodology_drc_routed.rpt -pb picoblaze_example_top_methodology_drc_routed.pb -rpx picoblaze_example_top_methodology_drc_routed.rpxZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
G
$Running Methodology with %s threads
74*drc2
8Z23-133h px� 
�
2The results of Report Methodology are in file %s.
609*	vivadotcl2�
r/home/lorenzo/Cont-Univ-PIcoBlaze/Cont-Univ-PIcoBlaze.runs/impl_1/picoblaze_example_top_methodology_drc_routed.rptr/home/lorenzo/Cont-Univ-PIcoBlaze/Cont-Univ-PIcoBlaze.runs/impl_1/picoblaze_example_top_methodology_drc_routed.rpt8Z2-1520h px� 
R
%s completed successfully
29*	vivadotcl2
report_methodologyZ4-42h px� 
�
Executing command : %s
56330*	planAhead2�
�report_timing_summary -max_paths 10 -report_unconstrained -file picoblaze_example_top_timing_summary_routed.rpt -pb picoblaze_example_top_timing_summary_routed.pb -rpx picoblaze_example_top_timing_summary_routed.rpx -warn_on_violation Z12-24828h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
`
UpdateTimingParams:%s.
91*timing2'
% Speed grade: -1, Delay Type: min_maxZ38-91h px� 
j
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
8Z38-191h px� 
�
)Running report commands "%s" in parallel.56334*	planAhead2@
>report_bus_skew, report_incremental_reuse, report_route_statusZ12-24838h px� 
Y
+Running report generation with %s threads.
56333*	planAhead2
3Z12-24831h px� 
�
Executing command : %s
56330*	planAhead2l
jreport_route_status -file picoblaze_example_top_route_status.rpt -pb picoblaze_example_top_route_status.pbZ12-24828h px� 
�
Executing command : %s
56330*	planAhead2S
Qreport_incremental_reuse -file picoblaze_example_top_incremental_reuse_routed.rptZ12-24828h px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
Executing command : %s
56330*	planAhead2�
�report_bus_skew -warn_on_violation -file picoblaze_example_top_bus_skew_routed.rpt -pb picoblaze_example_top_bus_skew_routed.pb -rpx picoblaze_example_top_bus_skew_routed.rpxZ12-24828h px� 
`
UpdateTimingParams:%s.
91*timing2'
% Speed grade: -1, Delay Type: min_maxZ38-91h px� 
j
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
8Z38-191h px� 
�
Executing command : %s
56330*	planAhead2�
�report_power -file picoblaze_example_top_power_routed.rpt -pb picoblaze_example_top_power_summary_routed.pb -rpx picoblaze_example_top_power_routed.rpxZ12-24828h px� 
�
Command: %s
53*	vivadotcl2�
�report_power -file picoblaze_example_top_power_routed.rpt -pb picoblaze_example_top_power_summary_routed.pb -rpx picoblaze_example_top_power_routed.rpxZ4-113h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1132
02
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
report_powerZ4-42h px� 
�
Executing command : %s
56330*	planAhead2S
Qreport_clock_utilization -file picoblaze_example_top_clock_utilization_routed.rptZ12-24828h px� 
�
jFailed to find the Oracle tile group with name '%s'. This is required for Clock regions and Virtual grid.
996*device2
HSR_BOUNDARY_TOPZ21-9320h px� 
E
"Failed to initialize Virtual grid.736*deviceZ21-2174h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Write ShapeDB Complete: 2
00:00:00.012

00:00:002

2982.7892
0.0002
8632
6942Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote PlaceDB: 2
00:00:00.052
00:00:00.022

2982.7892
0.0002
8632
6942Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote PulsedLatchDB: 2

00:00:002

00:00:002

2982.7892
0.0002
8632
6942Z17-722h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote RouteStorage: 2
00:00:00.022
00:00:00.012

2982.7892
0.0002
8632
6942Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote Netlist Cache: 2

00:00:002

00:00:002

2982.7892
0.0002
8632
6942Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote Device Cache: 2
00:00:00.012
00:00:00.012

2982.7892
0.0002
8622
6942Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Write Physdb Complete: 2
00:00:00.092
00:00:00.042

2982.7892
0.0002
8622
6942Z17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2d
b/home/lorenzo/Cont-Univ-PIcoBlaze/Cont-Univ-PIcoBlaze.runs/impl_1/picoblaze_example_top_routed.dcpZ17-1381h px� 


End Record