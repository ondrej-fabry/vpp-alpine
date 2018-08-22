# VPP on Alpine (with glibc)

:warning: NOTE: This is currently not working and is used for testing VPP compilation on alpine with glibc.

# Build image

`docker build .`

You can optionally set VPP commit to specific one:

`docker build --build-arg="VPP_COMMIT=xxxxx" .`

# Problems

Currently fails with `error: unknown type name 'cpu_set_t'`:

```sh
== Build lib/librte_eal/linuxapp/eal
  CC eal_hugepage_info.o
  CC eal_memory.o
  CC eal_thread.o
  CC eal_log.o
In file included from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/generic/rte_spinlock.h:21:0,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/rte_spinlock.h:12,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/rte_malloc_heap.h:10,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/rte_eal_memconfig.h:12,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/lib/librte_eal/linuxapp/eal/eal_memory.c:36:
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/rte_lcore.h:26:10: error: unknown type name 'cpu_set_t'
  typedef cpu_set_t rte_cpuset_t;
          ^~~~~~~~~
make[11]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/internal/rte.compile-pre.mk:114: eal_memory.o] Error 1
make[11]: *** Waiting for unfinished jobs....
In file included from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/rte_debug.h:17:0,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/lib/librte_eal/linuxapp/eal/eal_thread.c:15:
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/lib/librte_eal/linuxapp/eal/eal_thread.c: In function 'eal_thread_loop':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/lib/librte_eal/linuxapp/eal/eal_thread.c:125:13: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   lcore_id, (int)thread_id, cpuset, ret == 0 ? "" : "...");
             ^
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/x86_64-native-linuxapp-gcc/include/rte_log.h:322:32: note: in definition of macro 'RTE_LOG'
    RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)
                                ^~~~~~~~~~~
make[10]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.subdir.mk:37: eal] Error 2
make[9]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.subdir.mk:37: linuxapp] Error 2
make[8]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.subdir.mk:37: librte_eal] Error 2
make[7]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.sdkbuild.mk:51: lib] Error 2
make[6]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.sdkroot.mk:101: all] Error 2
make[5]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.sdkinstall.mk:58: pre_install] Error 2
make[4]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08/mk/rte.sdkroot.mk:79: install] Error 2
make[4]: Leaving directory '/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.08'
make[3]: *** [Makefile:344: build-dpdk] Error 2
make[3]: Leaving directory '/vpp/dpdk'
make[2]: *** [Makefile:484: ebuild-install] Error 2
make[2]: Leaving directory '/vpp/dpdk'
make[1]: *** [Makefile:730: dpdk-install] Error 2
make[1]: Leaving directory '/vpp/build-root'
make: *** [Makefile:343: build] Error 2

```
