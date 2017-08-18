--1) Use RDP to login to the appropriate cluster node i.e. for VSPSQ01\VSPSQ01 remote into VSPSQ01
--2) Open a dos prompt and execute the appropriate license command for the appropriate sql instance

sqlsafecmd license VSPSQ01\VSPSQ01 AT6VL-QURLY-A2P6H-V8V5R-R8H49N

sqlsafecmd license VSPSQ02\VSPSQ02 ASXQX-52EBM-T8SWU-XL3NF-UYU6MW

sqlsafecmd license VSPSQ03\VSPSQ03 AVKJ5-EXHXW-3VTJX-FW4WL-VLXNXW
