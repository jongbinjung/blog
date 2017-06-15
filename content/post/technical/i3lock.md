+++
categories = ["사용설명서"]
date = "2017-06-14T22:19:41-07:00"
description = "Gnome에서 i3lock으로 화면잠그기"
disqus = true
draft = false
mathjax = false
slug = "i3lock-on-gnome"
tags = [
  "리눅스",
  "fedora",
  "gnome",
  "i3",
  "설정",
]
title = "i3lock으로 화면 잠그기"

+++

<figure>
<iframe width="100%" height="400"
src="https://www.youtube.com/embed/ovs5daY9-Ek" frameborder="0"
allowfullscreen></iframe>
</figure>

최근, 스트레스 해소도 할 겸 작업 환경을 이리저리 꾸며 보던 중,
[i3wm](http://i3wm.org)를 알게 되었다. 
컨셉은 매력적이지만, 2-3일 사용해본 결과, 적업 능률에는 그닥 도움이 안되는
것 같아서, 금방 다시 `Gnome`으로 갈아 탔는데, `i3`에서 잠금화면으로 쓰던
`i3lock`이 계속 눈 앞에 아른 거렸다 … 아주 특별하달 건 없지만, 단순하게 설정할
수 있고, 뻔한 입력창 없이도 비밀번호를 입력 할 수 있는 점이 매력적이었다.
(작동하는 모습은 위 동영상 참고)

그래서, `Gnome`은 그대로 쓰면서, 화면 잠금 기능만 `i3lock`으로 바꾸는 방법을
오늘은 기록해 보려 한다. 막상 해 놓고 보니, 별거 아닌데, 정확히 뭘 어떻게
설정해야 되는지 알아내는 데에는 안타깝게도 꽤나 걸렸다는 …

## i3lock 설정

우선은,  `i3lock`을 마음에 쏙 들게 설정해야 한다. 
나는 [커뮤니티
사이트](https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen)에서 
본 예제를 기반으로 조금 수정했다.

위 동영상에서 보다시피, 결과물은 제법 그럴싸한 모자이크 효과가 된 잠금화면은데,
방법은 꽤 단순하다:

1. 화면캡쳐 툴인 `scrot`을 이용해 현재 화면을 임의파일(`/tmp/screen.png`)에
   저장한다.
1. `Imagemagick` 패키지에 포함된 툴 중 하나인 `convert`의 `scale` (이미지 크기
   변환) 기능을 이용해서, 앞서 화면 캡쳐한 파일을 10% 크기로 줄였다가 1000%
   크기로 다시 늘려서, 모자이크 효과를 연출한다.
1. `i3lock`의 `-i` 옵션을 이용해서, 잠금화면을 위 그림파일로 대체한다

위 세 단계를 간단하게 스크립트 파일로 다음과 같이 원하는 위치에 저장하고, 
파일을 실행 가능하도록 권한부여(`chmod +x`)하면, 일단 첫 단계는 끝!

```
#!/bin/bash

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
i3lock -e -f -i /tmp/screen.png
```

`i3lock`의 `-e` 옵션은 비밀번호를 입력하지 않으면 아무것도 하지 않도록
설정하고, `-f`는 비밀번호 틀린 횟수를 화면에 보여주도록 하는 옵션이다.

스크립트 파일을 저장했다면, `Gnome` 키보드 단축키 설정에서 해당 스크립트 파일을
실행 시키도록 단축키를 설정한다. 내 경우에는, 원래 `Gnome` 잠금화면 단축키인
`Super` + `L`을, 위 스크립트를 실행하도록 재설정했다.

## Gnome 잠금화면 비활성화

다음은 `Gnome`이 기본적으로 사용하는 잠금화면 관리자(`gdm`)를 비활성화
시켜야한다. 
이 부분이 사실, 뭔가 대단한 설정이 필요할 줄 알고 한참 찾아봤는데, 
알고보니, 그냥 기본 설정 (Settings > Privacy)에서 잠금화면 기능을 해제하면
되는 거였다는;;;

{{< figure
  src="/img/posts/i3lock/screen-lock-off.png"
  caption="설정화면에서 기본 화면잠금 기능은 다 끈다" >}}


## 전원 관리 연동

마지막으로, 단축키를 눌렀을 때뿐만 아니라, 
어떤 이유에서든지, 컴퓨터가 휴면(`suspend`) 상태에 들어 갔을 때 화면이 자동으로
잠기게 하고 싶다면, 최근 `Gnome` 환경에서는 `systemd`를 활용할 수 있다.

우선, 다음과 같은 내용의 파일을 `/etc/systemd/system/i3lock.service`라는 
이름으로 저장한다. 

``` 
[Unit]
Description=i3lock on suspend
Before=sleep.target

[Service]
User=사용자명
Type=forking
Environment=DISPLAY=:0
ExecStart={스크립트 위치}

[Install]
WantedBy=sleep.target
```

여기서 `사용자명`은 로그인하는 사용자의 아이디, 그리고 `{스크립트 위치}`는 앞서
만든 `i3lock` 스크립트가 저장 되어 있는 위치를 가리키도록 한다.
위 파일을 저장 한 다음, 터미널에서

```
$ systemctl enable i3lock
```

… 을 한 번 실행하면, 설정 끝!
