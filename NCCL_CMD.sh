/usr/local/openmpi/bin/mpirun --allow-run-as-root -np 2144 --hostfile hosts  --map-by slot -mca coll_hcoll_enable 0 -mca pml ob1 -mca routed direct -mca btl_tcp_if_include bond0 -mca oob_tcp_if_include bond0 -mca btl ^openib -x NCCL_SOCKET_IFNAME=bond0 -x NCCL_IB_HCA=mlx5_0,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7  -x NCCL_IB_QPS_PER_CONNECTION=8    -x NCCL_GDR_LEVEL=1   -x NCCL_DEBUG=INFO  -x NCCL_NVLS_ENABLE=0   /root/nccl-tests-2.14.1/build/all_reduce_perf -b 16GB -e 16GB  -f 0 -i 0   -g 1
/usr/local/openmpi/bin/mpirun --allow-run-as-root -np 2144 --hostfile hosts  --map-by slot -mca coll_hcoll_enable 0 -mca pml ob1 -mca routed direct -mca btl_tcp_if_include bond0 -mca oob_tcp_if_include bond0 -mca btl ^openib -x NCCL_SOCKET_IFNAME=bond0 -x NCCL_IB_HCA==mlx5_0,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7 --mca routed_radix 600    --mca plm_rsh_num_concurrent 300 -mca plm_rsh_no_tree_spawn 1 -x NCCL_IB_QPS_PER_CONNECTION=8 -x NCCL_MIN_NCHANNELS=32   -x NCCL_GDR_LEVEL=1 -x NCCL_NET_PLUGIN=/data0/libnccl-net.so.1  -x NCCL_DEBUG=INFO -x NCCL_BOND_LOAD_BALANCE=1  -x NCCL_NVLS_ENABLE=0   /root/nccl-tests-2.14.1/build/all_reduce_perf -b 16GB -e 16GB  -f 0 -i 0   -g 1
/usr/local/openmpi/bin/mpirun \
--allow-run-as-root -np $((8*1)) --hostfile hosts \
--map-by slot -mca coll_hcoll_enable 0 \
-mca pml ob1 -mca routed direct \
-mca btl_tcp_if_include bond0 \
-mca oob_tcp_if_include bond0 \
-mca btl ^openib \
--mca routed_radix 600 \
--mca plm_rsh_num_concurrent 300 \
-x NCCL_SOCKET_IFNAME=bond0 \
-x NCCL_IB_HCA==mlx5_0,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7 \
-x NCCL_IB_QPS_PER_CONNECTION=8 \
-x NCCL_PXN_DISABLE=0 \
-x NCCL_MIN_NCHANNELS=32 \
-x NCCL_GDR_LEVEL=1 \
-x NCCL_IB_TC=186  \
-x NCCL_DEBUG=info  \
-x NCCL_BOND_LOAD_BALANCE=1 /root/nccl-tests-2.14.1/build/all_reduce_perf \
-b 8GB -e 8GB -f 0 -i 0 -g 1

/usr/local/openmpi/bin/mpirun --allow-run-as-root -np $((8*1)) --hostfile hosts \
--map-by slot -mca coll_hcoll_enable 0 -mca pml ob1 -mca routed direct -mca btl_tcp_if_include bond0 -mca oob_tcp_if_include bond0 -mca btl ^openib --mca routed_radix 600 --mca plm_rsh_num_concurrent 300 \
-x NCCL_SOCKET_IFNAME=bond0 \
-x NCCL_IB_HCA==mlx5_0,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7 300 \
-mca plm_rsh_no_tree_spawn 1 \
-x NCCL_IB_QPS_PER_CONNECTION=8 \
-x NCCL_MIN_NCHANNELS=32 \
-x NCCL_GDR_LEVEL=1 \
-x NCCL_NET_PLUGIN=/data0/libnccl-net.so.1  \
-x NCCL_DEBUG=INFO \
-x NCCL_BOND_LOAD_BALANCE=1  \
-x NCCL_NVLS_ENABLE=0   \
/root/nccl-tests-2.14.1/build/all_reduce_perf \
-b 16GB -e 16GB  -f 0 -i 0   -g 1


/usr/local/openmpi/bin/mpirun --allow-run-as-root -np $((8*1)) --hostfile hosts \
--map-by slot \
-mca coll_hcoll_enable 0 \
-mca pml ob1 \
-mca routed direct \
-mca btl_tcp_if_include bond0 \
-mca oob_tcp_if_include bond0 \
-mca btl ^openib \
--mca routed_radix 600 \
--mca plm_rsh_num_concurrent 300 \
-x NCCL_SOCKET_IFNAME=bond0 \
-x NCCL_IB_HCA==mlx5_0,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7 \
-x NCCL_IB_QPS_PER_CONNECTION=8 \
-x NCCL_PXN_DISABLE=0 \
-x NCCL_MIN_NCHANNELS=32 \
-x NCCL_GDR_LEVEL=1 \
-x NCCL_IB_TC=186  \
-x NCCL_DEBUG=info \
-x NCCL_BOND_LOAD_BALANCE=1 /root/nccl-tests-2.14.1/build/all_reduce_perf \
-b 8GB -e 8GB -f 0 -i 0 -g 1



/usr/local/openmpi/bin/mpirun --allow-run-as-root -np $((8*1)) --hostfile hostfile \
        -mca plm_rsh_agent "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
        --map-by slot -mca coll_hcoll_enable 0  \
        -mca pml ob1 -mca routed direct \
        -mca btl_tcp_if_include bond0 \
        -mca oob_tcp_if_include bond0 -mca btl ^openib   \
        --mca routed_radix 600    \
        --mca plm_rsh_num_concurrent 300 \
        -mca plm_rsh_no_tree_spawn 1  \
        -x NCCL_SOCKET_IFNAME=bond0 \
        -x NCCL_IB_HCA=mlx5_0,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_5,mlx5_6,mlx5_7  \
        -x NCCL_MIN_NCHANNELS=32 \
        -x NCCL_IB_QPS_PER_CONNECTION=8    \
        -x NCCL_GDR_LEVEL=1   \
        -x NCCL_DEBUG=version  \
        -x NCCL_NVLS_ENABLE=0  \
        /root/nccl-tests-2.14.1/build/all_reduce_perf -b 1G -e 16GB  -f 2  -g 1 