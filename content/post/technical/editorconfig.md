+++
draft = false
date = "2017-02-22T16:43:10-08:00"
title = "편집기(vim) 자동설정"
description = """문서 설정이나 스타일 가이드가 다른 여러 개의 프로젝트에 참여 
  할 때 .editorconfig를 이용해서 설정을 관리하는 방법을 소개한다. 
  특히, vim을 이용할 때 PEP8, Makefile 등 다른 설정을 요구하는 파일 편집을 
  위한 기본 설정을 소개한다."""
mathjax = false
tags = [
  "설정",
  "연구",
  "프로젝트관리",
  ]
categories = ["사용설명서"]
disqus = true

slug = "editorconfig"
+++

사람마다, (프로그래밍) 언어마다, 선호하거나 요구하는 스타일/포맷이 있다.

예를 들어, Makefile은 반드시 탭으로 들여쓰기를 해야하고, 마크다운(Markdown)에서
목록 들여쓰기는 스페이스 4 개 이상을 써야한다. 같은 파이썬 내에서도
[PEP8](https://www.python.org/dev/peps/pep-0008/#indentation)을 따르면 스페이스
4개로 들여 쓰기를 해야하는 반면
[구글](https://developers.google.com/edu/python/introduction#indentation)은
내부적으로 스페이스 2개를 사용한다고 한다.

물론, 혼자 독자적인 프로젝트에만 작업을 한다면, 모든 프로젝트에 걸쳐서 똑같은
스타일을 적용하고, 사용하는 편집기(e.g., `vim`)의 설정(e.g., `.vimrc`,
`ftplugin`)을 통해 들여쓰기를 조절 할 수 있다. 하지만 서로 다른 단체에 걸친,
다른 사람들과 협업하는, 여러 개의 프로젝트에 기여를 하고 있다면, 같은
파일종류(e.g., `*.py`)에 작업 할 때도, 이느 프로젝트에서 작업을 하고 있느냐에
따라 필요한 설정이 달라질 수 있기 때문에, 문제가 복잡해진다.

이를 해결하기 위해 사용 할 수 있는 툴이
[editorconfig](http://editorconfig.org/)이다.

[Editorconfig](http://editorconfig.org/)는 각 프로젝트/폴더 별로, 들여쓰기나
인코딩 등의 기본적인 설정을 `.editorconfig` 파일로 지정하고, 각 편집기 별로 이를
읽어 들여서 동적으로 설정을 바꿀 수 있는 플러그인을 제공한다.

`Vim`을 사용하는 경우,
[editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) 플러그인을
설치하면, `vim`으로 파일을 열 때, 같은 폴더 혹은 가장 가까운 상위 폴더에 있는
`.editorconfig` 파일의 정보를 읽어들여서 `vim` 기본 설정(e.g., `tabstop`)을
변경한다.

예를 들어, 기본적으로 프로젝트의 최상위 폴더에 `.editorconfig` 파일을

```
# top-most EditorConfig file
root = true

[*]
charset = utf-8
indent_style = space
indent_size = 2

[*.py]
indent_size = 4

# Tab indentation (no size specified)
[Makefile]
indent_style = tab
```

으로 설정하면, 기본적으로 모든 파일에 스페이스 2개로 들여쓰기를 하는 반면,
파이썬 파일에서는 스페이스 4개, 그리고 Makefile은 탭으로 들여쓰기를 하도록
`vim`에서 자동으로 설정이 된다.
