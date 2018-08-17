# Alpine image with VPP

:warning: NOTE: This is currently not working and is used for testing VPP compilation on alpine with glibc.

# Build image

`docker build .`

You can optionally set VPP commit to specific one:

`docker build --build-arg="VPP_COMMIT=xxxxx" .`

# Problems

Currently fails with:

```sh
make[4]: Entering directory '/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05'
Configuration done using custom-config
== Build lib
== Build lib/librte_compat
== Build lib/librte_eal
== Build lib/librte_eal/common
== Build lib/librte_eal/linuxapp
== Build lib/librte_eal/linuxapp/eal
  CC eal_hugepage_info.o
  CC eal_memory.o
  CC eal_vfio.o
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'map_shared_memory':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:45:11: warning: implicit declaration of function 'open' [-Wimplicit-function-declaration]
  int fd = open(filename, flags, 0666);
           ^~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:45:2: warning: nested extern declaration of 'open' [-Wnested-externs]
  int fd = open(filename, flags, 0666);
  ^~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'open_shared_memory':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:61:47: error: 'O_RDWR' undeclared (first use in this function)
  return map_shared_memory(filename, mem_size, O_RDWR);
                                               ^~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:61:47: note: each undeclared identifier is reported only once for each function it appears in
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'create_shared_memory':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:67:47: error: 'O_RDWR' undeclared (first use in this function)
  return map_shared_memory(filename, mem_size, O_RDWR | O_CREAT);
                                               ^~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:67:56: error: 'O_CREAT' undeclared (first use in this function)
  return map_shared_memory(filename, mem_size, O_RDWR | O_CREAT);
                                                        ^~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'clear_hugedir':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:276:8: warning: implicit declaration of function 'openat' [-Wimplicit-function-declaration]
   fd = openat(dir_fd, dirent->d_name, O_RDONLY);
        ^~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:276:3: warning: nested extern declaration of 'openat' [-Wnested-externs]
   fd = openat(dir_fd, dirent->d_name, O_RDONLY);
   ^~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:276:39: error: 'O_RDONLY' undeclared (first use in this function)
   fd = openat(dir_fd, dirent->d_name, O_RDONLY);
                                       ^~~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'hugepage_info_init':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:362:45: error: 'O_RDONLY' undeclared (first use in this function)
   hpi->lock_descriptor = open(hpi->hugedir, O_RDONLY);
                                             ^~~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'open_shared_memory':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:62:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c: In function 'create_shared_memory':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c:68:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^
In file included from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/generic/rte_spinlock.h:21:0,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_spinlock.h:12,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_malloc_heap.h:10,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_eal_memconfig.h:12,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:36:
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_lcore.h:26:10: error: unknown type name 'cpu_set_t'
  typedef cpu_set_t rte_cpuset_t;
          ^~~~~~~~~
  CC eal_interrupts.o
make[11]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/internal/rte.compile-pre.mk:116: eal_hugepage_info.o] Error 1
make[11]: *** Waiting for unfinished jobs....
In file included from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/generic/rte_spinlock.h:21:0,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_spinlock.h:12,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_malloc_heap.h:10,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_eal_memconfig.h:12,
                 from /vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_vfio.c:14:
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/x86_64-native-linuxapp-gcc/include/rte_lcore.h:26:10: error: unknown type name 'cpu_set_t'
  typedef cpu_set_t rte_cpuset_t;
          ^~~~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c: In function 'rte_mem_virt2phy':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:109:7: warning: implicit declaration of function 'open' [-Wimplicit-function-declaration]
  fd = open("/proc/self/pagemap", O_RDONLY);
       ^~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:109:2: warning: nested extern declaration of 'open' [-Wnested-externs]
  fd = open("/proc/self/pagemap", O_RDONLY);
  ^~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:109:34: error: 'O_RDONLY' undeclared (first use in this function)
  fd = open("/proc/self/pagemap", O_RDONLY);
                                  ^~~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:109:34: note: each undeclared identifier is reported only once for each function it appears in
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c: In function 'aslr_enabled':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:207:49: error: 'O_RDONLY' undeclared (first use in this function)
  int retval, fd = open(RANDOMIZE_VA_SPACE_FILE, O_RDONLY);
                                                 ^~~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c: In function 'map_all_hugepages':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:334:27: error: 'O_CREAT' undeclared (first use in this function)
   fd = open(hf->filepath, O_CREAT | O_RDWR, 0600);
                           ^~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:334:37: error: 'O_RDWR' undeclared (first use in this function)
   fd = open(hf->filepath, O_CREAT | O_RDWR, 0600);
                                     ^~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c: In function 'create_shared_memory':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:524:26: error: 'O_CREAT' undeclared (first use in this function)
  int fd = open(filename, O_CREAT | O_RDWR, 0666);
                          ^~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:524:36: error: 'O_RDWR' undeclared (first use in this function)
  int fd = open(filename, O_CREAT | O_RDWR, 0666);
                                    ^~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c: In function 'remap_segment':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:708:30: error: 'O_RDWR' undeclared (first use in this function)
   fd = open(hfile->filepath, O_RDWR);
                              ^~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c: In function 'eal_legacy_hugepage_attach':
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:1730:47: error: 'O_RDONLY' undeclared (first use in this function)
  fd_hugepage = open(eal_hugepage_data_path(), O_RDONLY);
                                               ^~~~~~~~
/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/lib/librte_eal/linuxapp/eal/eal_memory.c:1762:27: error: 'O_RDWR' undeclared (first use in this function)
   fd = open(hf->filepath, O_RDWR);
                           ^~~~~~
make[11]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/internal/rte.compile-pre.mk:116: eal_memory.o] Error 1
make[11]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/internal/rte.compile-pre.mk:116: eal_vfio.o] Error 1
make[10]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.subdir.mk:37: eal] Error 2
make[9]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.subdir.mk:37: linuxapp] Error 2
make[8]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.subdir.mk:35: librte_eal] Error 2
make[7]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.sdkbuild.mk:51: lib] Error 2
make[6]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.sdkroot.mk:101: all] Error 2
make[5]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.sdkinstall.mk:58: pre_install] Error 2
make[4]: *** [/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05/mk/rte.sdkroot.mk:79: install] Error 2
make[4]: Leaving directory '/vpp/build-root/build-vpp_debug-native/dpdk/dpdk-18.05'
make[3]: *** [Makefile:329: build-dpdk] Error 2
make[3]: Leaving directory '/vpp/dpdk'
make[2]: *** [Makefile:469: ebuild-install] Error 2
make[2]: Leaving directory '/vpp/dpdk'
make[1]: *** [Makefile:730: dpdk-install] Error 2
make[1]: Leaving directory '/vpp/build-root'
make: *** [Makefile:335: build] Error 2

```