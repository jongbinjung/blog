+++
draft = false
disqus = true
categories = [
  "사용설명서",
]
tags = [
  "리눅스",
  "부팅",
  "Fedora",
  "grub2",
  "설정",
]
mathjax = false
date = "2016-12-20T21:04:43-08:00"
title = "Fedora에서 부팅 화면 숨기기"
description = "GRUB2 이용하는 Fedora에서 부팅 옵션 화면 숨기기"

+++

매번 OS 업데이트/변경 할 때마다 다시 세팅 해야되는데, 그 때마다 기억이 나지
않고 검색하게 되서, 편의상 여기에 기록해둔다.

우선 `/etc/default/grub`에 다음 옵션을 추가한다

```bash
GRUB_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT=1
GRUB_HIDDEN_TIMEOUT_QUITE=true
```

그 다음 부팅 설정을 업데이트 해야하는데, 이는 UEFI를 사용하느냐에 따라 설정 위치
가조금씩 다르다. 보통 요즘 나오는 기기들은 다 UEFI 사용하긴 하지만, 정확한
output 위치를 `/etc`에 symlink를 찾아서 알아볼 수 있다.

설정을 업데이트 하려면 아래 명령어를 이용하면 된다(설정 대상 파일을 `-o`로 지목
할 수 있다):

```bash
grub2-mkconfig -o /boot/grub2/grub.cfg
```
