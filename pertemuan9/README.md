# Cara install Docker Manjaro Linux
Update system:

```shell
$ sudo pacman -Syu
```
Install docker:
```shell
$ sudo pacman -S docker
```
Enable service:
```shell
$ sudo systemctl start docker.service
$ sudo systemctl enable docker.service
```
Verify installation:
```shell
$ sudo docker version
```
<details>
<summary>Contoh hasil run:</summary>

```yaml
Client:
 Version:           20.10.14
 API version:       1.41
 Go version:        go1.18
 Git commit:        a224086349
 Built:             Thu Mar 24 08:56:17 2022
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server:
 Engine:
  Version:          20.10.14
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.18
  Git commit:       87a90dc786
  Built:            Thu Mar 24 08:56:03 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v1.6.2
  GitCommit:        de8046a5501db9e0e478e1c10cbcfb21af4c6b2d.m
 runc:
  Version:          1.1.1
  GitCommit:        
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

</details>

Docker Info:
```shell
$ sudo docker info
```
<details>
<summary>Contoh hasil run:</summary>

```yaml
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc., v0.8.1-docker)
  scan: Docker Scan (Docker Inc., v0.1.0-227-g061fe0a0c5)

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 20.10.14
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: false
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runtime.v1.linux runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: de8046a5501db9e0e478e1c10cbcfb21af4c6b2d.m
 runc version: 
 init version: de40ad0
 Security Options:
  seccomp
   Profile: default
  cgroupns
 Kernel Version: 5.15.32-1-MANJARO
 Operating System: Manjaro Linux
 OSType: linux
 Architecture: x86_64
 CPUs: 4
 Total Memory: 10.72GiB
 Name: MAIRY
 ID: FOL6:75SK:LHCD:IQXK:SES5:IZ5V:6JPN:OX5J:IHNG:EV6T:LJYX:R7TW
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

</details>