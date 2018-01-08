---
title: "ggplot2 한글 폰트 설정"
tags: ["R", "데이터", "시각화", "ggplot", "한글", "폰트"]
categories: ["사용설명서"]

author: "정종빈"
date: "2016-12-12T09:36:33-08:00"

draft: false
mathjax: false
disqus: true

slug: "ggplot2-korean-font"
---



데이터를 바탕으로 한 "의미있는" 그래프를 그리고자 할 때는 역시 R의
[ggplot2](http://ggplot2.org)만한게 없다.
연구든, 일이든, 발표든, 늘 그래프를 그릴 일이 있을 때면 ggplot2를 문제 없이 잘
쓰다가, 한글로 블로그질을 하려니까 폰트가 도무지 봐줄 수 없는거라.

<!--more-->

<img src="/img/posts/R/figure/bad Korean font example-1.png" title="plot of chunk bad Korean font example" alt="plot of chunk bad Korean font example" width="500" style="display: block; margin: auto;" />

그래서 (잘 하지도 않는) 블로그질을 위해 굳이 ggplot2에서 폰트를 (비교적 쉽게)
설정하는 방법을 찾아내서, 행여나 나와 비슷한 처지에 있는 누군가에게 도움이 될
수도 있지 않을까 싶어 공유해본다.

<img src="/img/posts/R/figure/good Korean font example-1.png" title="plot of chunk good Korean font example" alt="plot of chunk good Korean font example" width="500" style="display: block; margin: auto;" />

# 기본 설정

우선, 사용하고자 하는 폰트가 시스템에 설치 되어있다고 가정한다.
참고로, 위 예제에서 사용된 폰트는 [헤움디자인](http://heumm.com/)에서 무료로
배포하는 [헤움담은명조](http://www.heumm.com/bbs/board.php?bo_table=download&wr_id=28170)와
[헤움진고딕v3](http://www.heumm.com/bbs/board.php?bo_table=download&wr_id=26926)이다(회원가입
및 로그인 필요).

# R 작업환경으로 폰트 읽어오기

폰트를 사용하기 위해서는, R 내에서 폰트의 존재를 알릴 필요가 있다.
보통은 다소 복잡한 과정을 거치지만, [extrafont]( https://cran.r-project.org/web/packages/extrafont/README.html)
라이브러리를 이용하면 보다 편하게 시스템 폰트를 불러올 수 있다.
(2016년 12월 현재, 아직은 ttf  폰트만 지원된다고 함)

R 작업환경으로 폰트를 불러오는 작업은 한 기기당 한 번만 하면 된다.


```
# 최초 라이브러리 설치
install.packages('extrafont')

# 불러오기
library(extrafont)
```

extrafont 라이브러리를 설치하고 불러온 후에는, `font_import()` 기능을 이용해서
원하는 폰트를 읽으면 된다.
(적어도 내가 느끼기에) 가장 빠르고 편한 방법은, `pattern` 옵션을 이용해서 원하는
폰트를 찾아서 읽어오는 방법이다.

예를 들어, 폰트 이름이 HUJingo로 시작되는 헤움진고딕 폰트들을 읽어오고 싶다면


```
font_import(pattern = 'HUJingo')
```

참고로, 아무 옵션 없이 `font_import()`하면, 시스템의 모든 폰트를 읽어오기 때문에
보유한 폰트의 수에 따라 시간이 어마어마하게 걸릴 수 있으니, 주의하자!

설치된 폰트는 `fonttable()`을 이용해 확인해 볼 수 있다.

# ggplot2에서 폰트 설정

폰트를 읽어왔다면, ggplot2에서 폰트 설정은, `theme` 혹은 각 `geom_*`의
`family` 옵셔을 활용한다.


```
df <- data.frame(
  x = c(1, 2, 1, 2, 1.5),
  y = c(1, 1, 2, 2, 1.5),
  text = c("좌측하단", "우측하단", "좌측상단", "우측상단", "가운데")
)

ggplot(data=df, aes(x, y)) +
  geom_text(aes(label = text), vjust="inward", hjust="inward") +
  ggtitle('예제의 제목 - 못생긴 기본 폰트',
          '예제의 소제목')
```

<img src="/img/posts/R/figure/basic-1.png" title="plot of chunk basic" alt="plot of chunk basic" width="500" style="display: block; margin: auto;" />

예를 들어, ggplot2가 만드는 모든 그래프의 기본 폰트를 바꾸고 싶으면
`theme_update()`를 이용해서 기본 설정을 바꾼다.
`theme_update()`를 적용한 시점 이후의 모든 그래프는 해당 테마가 적용된다.


```
theme_update(text=element_text(family="HUJingo340"))

ggplot(data=df, aes(x, y)) +
  geom_text(aes(label = text), vjust="inward", hjust="inward") +
  ggtitle('예제의 제목 - HUJingo340 기본 폰트',
          '예제의 소제목')
```

<img src="/img/posts/R/figure/default text family-1.png" title="plot of chunk default text family" alt="plot of chunk default text family" width="500" style="display: block; margin: auto;" />

각 `geom_*`의 폰트는 보통 `family` 매핑으로 조절 가능하다:


```
ggplot(data=df, aes(x, y)) +
  geom_text(aes(label = text), vjust="inward", hjust="inward",
            family="HUIncludemyungjo140") +
  ggtitle('예제의 제목 - HUJingo340 기본 폰트',
          '예제의 소제목')
```

<img src="/img/posts/R/figure/geom family mapping-1.png" title="plot of chunk geom family mapping" alt="plot of chunk geom family mapping" width="500" style="display: block; margin: auto;" />

제목/소제목/축이름 등 `geom_*` 외의 텍스트 일반적으로
[`theme()`](http://docs.ggplot2.org/current/theme.html)을 통해 조율 가능하다:


```
ggplot(data=df, aes(x, y)) +
  geom_text(aes(label = text), vjust="inward", hjust="inward",
            family="HUIncludemyungjo140") +
  ggtitle('예제의 제목 - HUJingo340 기본 폰트',
          '예제의 소제목 - 변경: HUIncludemyunjo140') +
  theme(plot.subtitle=element_text(family="HUIncludemyungjo140"))
```

<img src="/img/posts/R/figure/theme family mapping-1.png" title="plot of chunk theme family mapping" alt="plot of chunk theme family mapping" width="500" style="display: block; margin: auto;" />
