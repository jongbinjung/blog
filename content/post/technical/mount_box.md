+++
date = "2017-03-21T11:08:26-07:00"
description = "리눅스(Fedora)에서 mount와 davfs2를 이용해서 투명하게 Box 계정을 사용하는 방법"
mathjax = false
tags = [
  "리눅스",
  "Fedora",
  "davfs2",
  "Box",
  "설정",
]
title = "리눅스에서 Box 계정 사용하기"
draft = false
slug = "mount-box-on-fedora"
categories = ["사용설명서"]
disqus = true

+++

최근 의대와 협업을 하면서, 보안 문제로 인해 학교에서 제공하는 Box 계정을
사용해야만 하게 됐다. 그런데, Box는 공식적으로 윈도우/맥만 지원하고, 리눅스 용
툴들은 하나도 지원하지 않아서, 한 동안 윈도우 VM으로만 이용하다가, 최근에
WebDAV를 이용해서 Box 폴더를 아예 폴더로 mount할 수 있음을 깨닫고, 미래의
나를 위해 여기에 기록해 둠.

우선, `davfs2`가 설치 되어있어야 하는데, Fedora, CentOS, RHEL 등의 경우 아래와
같이 `dnf`를 사용하고, (보다 보편적인) 우분투, 데비안, 민트 등에서는 `apt-get`을
이용해서 쉽게 설치 할 수 있다.

```bash
$ sudo dnf install davfs2  # Fedora, CentOS, RHEL …
$ sudo apt-get install davfs2  # Ubuntu, Debian, Mint …
```

Box 계정을 mount 할 폴더를 만든다. 내 경우에는, 홈(`~`) 디렉토리 아래에
`box`라는 이름으로 아래와 같이 생성했다.

```bash
$ mkdir ~/box
```

Box에서 제공하는 WebDAV 공유 기능은 file lock을 지원하지 않기 때문에,
`davfs2` 설정에서 `use_locks` 기능을 해제해야 한다. 텍스트 편집기로
`/etc/davfs2/davfs2.conf` 파일을 열어서,

```
use_locks    0
```

한 줄을 추가한다. 어쩌면 이미 `use_locks    1`이 있을 수 있는데, 그럴 경우
`1`을 `0`으로 바꿔준다.

관리자 계정이 아닌 일반 사용자 계정으로 Box를 mount하고자 한다면, 해당 사용자를
`davfs2` 사용자 그룹에 추가해야한다. Ubuntu, Debian, Mint 등을 사용하는 경우,
우선 아래 명령어를 실행한다:

```bash
$ sudo dpkg-reconfigure davfs2
```

이어서 나타나는 화면에서 `<Yes>`를 선택.

그 후, (모든 리눅스 버전에서 마찬가지로) 아래 명령어를 이용해서 `jongbin`이라는
사용자를 `davfs2` 그룹에 추가할 수 있다.

```bash
$ sudo usermod -a -G davfs2 xmodulo
```

그런 다음, `/etc/fstab` 파일을 텍스트 편집기로 열어서, 아래 한 줄을 추가한다.

```
https://dav.box.com/dav <폴더위치> davfs rw,user,noauto 0 0
```

위에서 `<폴더위치>`는 앞서 `mkdir`로 생성했던, Box 계정을 mount 할 폴더
위치로 바꿔준다.

이제 `mount` 명령어를 이용해서 언제든 Box 계정을 로컬 폴더 처럼 이용할 수 있다.

```bash
$ mount <폴더위치>
```

`mount`를 할 때, 계정 아이디와 비밀번호를 물어보는데, 만약 매번 입력하는게
번거롭다면, `~/.davfs2/secrets` 파일을 만들어서 아이디/비번을 저장해 놓을
수 있다.

```bash
$ chmod 600 ~/.davfs2/secrets
```

로 파일 권한을 설정하고, 텍스트 편집기로 `~/.davfs2/secrets` 파일을 열어서,
아래와 같이 한 줄을 추가한다.

```
https://dav.box.com/dav my_email@address.com my_box_com_password
```

다만, 이 경우 아이디/비번을 텍스트 파일로 저장하게 됨으로, 보안에 주의하자!


Box 계정을 다 사용한 후에는 `umount` 명령으로 아래와 같이 안전하게 unmount할
수있다.

```bash
umount <폴더위치>
```
