---
title: "연초 실업률 증가"
description: "한국 실업률이 연초에 주기적으로 증가하는 현상에 대해 생각해보다"
tags: ["R", "데이터", "시각화", "연구", "실험", "실업률"]
categories: ["분석"]

author: "정종빈"
date: "2016-12-18T14:25:10-08:00"

draft: true
mathjax: false
disqus: true

slug: "seasonal-unemployment"
---







얼마전 [ggplot에서 한글 폰트 관련 글]({{< relref "/post/rmd/tutorials/ggplotko.md" >}})을
쓰면서 예제로 통계정이 발표한 월간 실업률 자료를 이용했는데, 통계청에서 공개한
데이터를 있는 그대로 봐서는 별 의미가 없는 것 같아서, 더 분석해 보고자 한다.

<img src="/img/posts/R/figure/motivation-1.png" title="plot of chunk motivation" alt="plot of chunk motivation" width="500" style="display: block; margin: auto;" />

우선, 당장에 알 수 있는 점은

- 90년대말 경제위기의 영향인지, 2000년대 초반에 실업률이 상대적으로 높았다
- 매년초에는 실업률이 오른다

2000년대 초반에 아주 높았던 부분은 제외하고, 2003년 이후만 보자.



<img src="/img/posts/R/figure/by president-1.png" title="plot of chunk by president" alt="plot of chunk by president" width="500" style="display: block; margin: auto;" />

<img src="/img/posts/R/figure/multi features-1.png" title="plot of chunk multi features" alt="plot of chunk multi features" width="500" style="display: block; margin: auto;" />

<img src="/img/posts/R/figure/loess regression-1.png" title="plot of chunk loess regression" alt="plot of chunk loess regression" width="500" style="display: block; margin: auto;" />






