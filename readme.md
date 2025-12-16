# PHBS 硕士学位论文 LaTeX 模板 (2025)

胖虎别墅的学弟学妹们，你们好！

这是适配 **2025年北大汇丰商学院硕士毕业论文格式要求** 的 LaTeX 模板。本说明会手把手教你从零开始，完成整个论文的写作和提交。

**请认真阅读本说明，遇到问题先查阅本文档。**

---

## 目录

1. [在开始之前](#在开始之前)
2. [环境安装](#环境安装)
   - [macOS 用户](#macos-用户)
   - [Windows 用户](#windows-用户)
3. [获取模板](#获取模板)
4. [项目结构说明](#项目结构说明)
5. [第一次编译](#第一次编译)
6. [配置你的论文信息](#配置你的论文信息)
7. [论文写作流程](#论文写作流程)
8. [参考文献管理](#参考文献管理)
9. [图片和表格](#图片和表格)
10. [数学公式](#数学公式)
11. [分阶段提交说明](#分阶段提交说明)
12. [版本管理 (Git)](#版本管理-git)
13. [常见问题](#常见问题)
14. [必读附件](#必读附件)

---

## 在开始之前

### 为什么用 LaTeX？

- **告别格式噩梦**：LaTeX 自动处理页边距、字号、行距、页眉页脚
- **专注内容**：你只需要写内容，格式由模板处理
- **数学公式**：LaTeX 的公式排版是 Word 无法比拟的
- **参考文献**：自动生成、自动编号、自动排序
- **版本管理**：纯文本文件，可以用 Git 追踪每次修改

### 什么是终端 (Terminal)？

终端是一个命令行工具，你可以通过输入命令来操作电脑。本模板的编译需要在终端中运行命令。

**打开终端的方法：**

- **macOS**: 按 `Cmd + 空格`，输入 `Terminal`，回车
- **Windows**: 按 `Win + R`，输入 `cmd`，回车；或者搜索 `PowerShell`

**基本命令：**

```bash
# 查看当前目录
pwd                    # macOS/Linux
cd                     # Windows (不带参数)

# 列出当前目录的文件
ls                     # macOS/Linux
dir                    # Windows

# 切换目录
cd /path/to/folder     # 进入某个目录
cd ..                  # 返回上级目录

# 示例：进入下载文件夹
cd ~/Downloads         # macOS
cd C:\Users\你的用户名\Downloads  # Windows
```

---

## 环境安装

### macOS 用户

#### 第一步：安装 Homebrew (包管理器)

打开终端，粘贴以下命令并回车：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成后，关闭终端，重新打开。

#### 第二步：安装 MacTeX (LaTeX 发行版)

```bash
brew install --cask mactex
```

这个安装包约 4GB，需要较长时间，请耐心等待。

安装完成后，**关闭终端，重新打开**，然后验证安装：

```bash
xelatex --version
latexmk --version
```

如果显示版本号，说明安装成功。

#### 第三步：安装 PDF 合并工具

```bash
brew install poppler
```

验证安装：

```bash
pdfunite --version
```

#### 第四步：安装 VS Code

```bash
brew install --cask visual-studio-code
```

或者从官网下载：https://code.visualstudio.com/

#### 第五步：安装 LaTeX Workshop 插件

1. 打开 VS Code
2. 按 `Cmd + Shift + X` 打开扩展面板
3. 搜索 `LaTeX Workshop`
4. 点击 `Install` 安装
5. 重启 VS Code

#### 第六步：配置 LaTeX Workshop

1. 按 `Cmd + ,` 打开设置
2. 点击右上角的 `{}` 图标，打开 `settings.json`
3. 添加以下配置：

```json
{
    "latex-workshop.latex.recipe.default": "latexmk (xelatex)",
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-xelatex",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "latexmk (xelatex)",
            "tools": ["latexmk"]
        }
    ]
}
```

---

### Windows 用户

#### 第一步：安装 TeX Live

1. 下载安装程序：https://mirror.ctan.org/systems/texlive/tlnet/install-tl-windows.exe
2. 运行安装程序，选择 `Install`
3. 安装过程约需 1-2 小时，请耐心等待
4. 安装完成后，**重启电脑**

验证安装（打开 PowerShell 或 CMD）：

```powershell
xelatex --version
latexmk --version
```

#### 第二步：安装 Poppler (PDF 合并工具)

1. 安装 Chocolatey 包管理器（以管理员身份打开 PowerShell）：

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

2. 安装 Poppler：

```powershell
choco install poppler
```

3. **重启 PowerShell**，验证安装：

```powershell
pdfunite --version
```

#### 第三步：安装 VS Code

从官网下载安装：https://code.visualstudio.com/

#### 第四步：安装 LaTeX Workshop 插件

1. 打开 VS Code
2. 按 `Ctrl + Shift + X` 打开扩展面板
3. 搜索 `LaTeX Workshop`
4. 点击 `Install` 安装
5. 重启 VS Code

#### 第五步：配置 LaTeX Workshop

1. 按 `Ctrl + ,` 打开设置
2. 点击右上角的 `{}` 图标，打开 `settings.json`
3. 添加以下配置（同 macOS 的配置）

#### 第六步：安装 Git (可选但强烈推荐)

```powershell
choco install git
```

---

## 获取模板

### 方法一：直接下载

1. 从学长提供的链接下载 ZIP 文件
2. 解压到你喜欢的位置（建议放在 `Documents` 或 `桌面`）
3. **不要放在中文路径下**，否则可能编译失败

### 方法二：使用 Git Clone (推荐)

```bash
# macOS
cd ~/Documents
git clone <仓库地址> my-thesis

# Windows
cd C:\Users\你的用户名\Documents
git clone <仓库地址> my-thesis
```

---

## 项目结构说明

```
my-thesis/
│
├── configs.tex              # 【必须修改】你的论文配置
│
├── parts/                   # 论文内容
│   ├── cover/               # 封面 (不用改)
│   ├── en/                  # 英文版
│   │   ├── chap/            # 【必须修改】英文章节
│   │   │   ├── abstract.tex # 英文摘要
│   │   │   ├── chap1.tex    # 第一章
│   │   │   ├── chap2.tex    # 第二章
│   │   │   └── ...
│   │   └── ref.bib          # 【必须修改】英文参考文献
│   └── zh/                  # 中文版
│       ├── chap/            # 【必须修改】中文章节
│       │   ├── abstract.tex     # 中文摘要
│       │   ├── acknowledgement.tex  # 致谢
│       │   ├── chap1.tex    # 第一章
│       │   ├── chap2.tex    # 第二章
│       │   └── ...
│       └── ref.bib          # 【必须修改】中文参考文献
│
├── pdf/                     # 【必须替换】签字 PDF
│   ├── 版权声明.pdf         # 从门户下载
│   └── 原创性声明.pdf       # 签字扫描版
│
├── shared/                  # 共享资源 (不要动!)
│   ├── pkuthss.cls          # 论文样式
│   ├── miscs.tex            # 宏定义
│   └── img/                 # 校徽等图片
│
├── output/                  # 编译输出 (自动生成)
│   ├── blind/               # 盲审版
│   ├── defense/             # 答辩版
│   └── final/               # 最终版
│
├── Makefile                 # 编译脚本 (不用改)
├── .latexmkrc               # latexmk 配置 (不用改)
├── readme.md                # 本说明文档
│
└── 附件*/                   # 【必读】官方格式要求
```

### 哪些文件需要修改？

| 文件 | 是否修改 | 说明 |
|------|----------|------|
| `configs.tex` | ✅ 必须修改 | 填写你的论文信息 |
| `parts/zh/chap/*.tex` | ✅ 必须修改 | 中文论文内容 |
| `parts/en/chap/*.tex` | ✅ 必须修改 | 英文论文内容 |
| `parts/zh/ref.bib` | ✅ 必须修改 | 中文参考文献 |
| `parts/en/ref.bib` | ✅ 必须修改 | 英文参考文献 |
| `pdf/*.pdf` | ✅ 必须替换 | 签字的 PDF 文件 |
| `shared/*` | ❌ 不要动 | 模板核心文件 |
| `parts/cover/*` | ❌ 不要动 | 封面自动生成 |
| `Makefile` | ❌ 不要动 | 编译脚本 |

---

## 第一次编译

确保环境安装成功后，让我们编译一次模板，看看效果。

### 第一步：打开终端，进入项目目录

```bash
# macOS
cd ~/Documents/my-thesis

# Windows
cd C:\Users\你的用户名\Documents\my-thesis
```

### 第二步：运行编译命令

```bash
make
```

这个命令会编译三个版本（盲审、答辩、最终），大约需要 2-5 分钟。

### 第三步：查看输出

编译成功后，你会看到：

```
============================================================
  全部编译完成!
============================================================

  输出文件:
    output/blind/thesis.pdf    <- 盲审版 (送审用)
    output/defense/thesis.pdf  <- 答辩版 (答辩用)
    output/final/thesis.pdf    <- 最终版 (存档用)
```

打开 `output/final/thesis.pdf` 查看效果。

### 常用编译命令

```bash
make              # 编译三个版本
make blind        # 只编译盲审版
make defense      # 只编译答辩版
make final        # 只编译最终版

make zh           # 只编译中文版 (写作时快速预览)
make en           # 只编译英文版
make watch-zh     # 监视模式，保存时自动编译

make clean        # 清理编译缓存
make cleanall     # 清理所有生成文件
make help         # 查看帮助
```

---

## 配置你的论文信息

打开 `configs.tex`，这是你需要修改的第一个文件。

### 可以修改的配置

```latex
% ============================================================
% 【重要】当前阶段设置
% ============================================================
% 一般不用改这里，通过 make blind/defense/final 命令控制
\newcommand{\stage}{final}

% ============================================================
% 论文标题
% ============================================================
% 中文标题 (使用 \zhquote{} 输入中文引号)
\newcommand{\zhtitle}{你的中文标题}
% 英文标题 (使用 \enquote{} 输入英文引号)
\newcommand{\entitle}{Your English Title}
% 标题行数 (用于封面排版，根据标题长度调整: 1/2/3)
\newcommand{\titlelines}{2}

% ============================================================
% 作者信息
% ============================================================
\newcommand{\zhauthorname}{你的中文姓名}
\newcommand{\enauthorname}{Your English Name}
\newcommand{\mystudentid}{你的学号}

% ============================================================
% 导师信息
% ============================================================
% 格式: 姓名 + 两个空格 + 职称
% 职称: 教授 / 副教授 / 讲师 / 助理教授
\newcommand{\zhmentorname}{导师姓名\ \ 教授}
% 英文格式: Prof. / A.P. / Lec.
\newcommand{\enmentorname}{Prof.\ Mentor Name}

% ============================================================
% 专业信息
% ============================================================
% 专业名称 (选一个):
%   金融硕士 / 西方经济学 / 企业管理 / 新闻与传播硕士
\newcommand{\zhmajor}{金融硕士}
%   Master of Finance / Master of Economics / 
%   Master of Management / Master of Journalism and Communication
\newcommand{\enmajor}{Master of Finance}
% 研究方向 (金融专业必填，其他专业留空):
%   金融管理 / 数量金融 / 金融科技 / 金融投资 / 财经传媒
\newcommand{\majordirection}{金融管理}
% 学位类型: true = 学术学位, false = 专业学位
\newcommand{\isacademicdegree}{false}

% ============================================================
% 关键词
% ============================================================
\newcommand{\zhkeywords}{关键词1，关键词2，关键词3}
\newcommand{\enkeywords}{Keyword1, Keyword2, Keyword3}

% ============================================================
% 日期
% ============================================================
% 具体时间以教务通知为准
\newcommand{\theyear}{2025}
\newcommand{\themonth}{5}  % 初稿3月，送审4月，答辩5月，最终6月
```

### 不要修改的部分

`configs.tex` 文件下半部分（从 `% 以下内容自动处理，无需修改` 开始）不要动，那是自动处理阶段逻辑的代码。

---

## 论文写作流程

### 推荐的写作顺序

1. **先写中文版**，再翻译成英文版
2. **先写正文**（chap1-6），再写摘要
3. **最后写致谢**

### 具体步骤

#### 第一步：写中文正文

按章节顺序编写 `parts/zh/chap/` 下的文件：

| 文件 | 内容 |
|------|------|
| `chap1.tex` | 第一章：引言/绑论 |
| `chap2.tex` | 第二章：文献综述 |
| `chap3.tex` | 第三章：理论模型/研究设计 |
| `chap4.tex` | 第四章：实证分析/案例分析 |
| `chap5.tex` | 第五章：进一步分析/讨论 |
| `chap6.tex` | 第六章：结论 |

**写作时预览：**

```bash
make zh   # 快速编译中文版，查看效果
```

或使用监视模式（保存时自动编译）：

```bash
make watch-zh
```

按 `Ctrl + C` 退出监视模式。

#### 第二步：写中文摘要

编辑 `parts/zh/chap/abstract.tex`：

```latex
\begin{cabstract}
    \addcontentsline{toc}{chapter}{摘要}

    在这里写你的中文摘要...
    
    摘要应该包含：研究背景、研究问题、研究方法、主要结论。
    一般 300-500 字。
\end{cabstract}
```

#### 第三步：翻译英文版

将中文内容翻译到 `parts/en/chap/` 对应的文件中。

**翻译建议：**
- 可以先用 ChatGPT/Claude 翻译初稿
- 然后自己润色修改
- 专业术语要准确

#### 第四步：写致谢

编辑 `parts/zh/chap/acknowledgement.tex`：

```latex
\chapter*{致谢}
\addcontentsline{toc}{chapter}{致谢}

在这里写你的致谢...

感谢导师、感谢家人、感谢同学...
```

**注意**：致谢只在最终版 (final) 中出现，盲审版和答辩版会自动隐藏。

#### 第五步：添加参考文献

见下一节详细说明。

---

## 参考文献管理

### 推荐工具：Zotero

[Zotero](https://www.zotero.org/) 是一个免费的文献管理工具，强烈推荐使用。

#### 安装 Zotero

1. 下载安装：https://www.zotero.org/download/
2. 安装浏览器插件 Zotero Connector
3. 安装 Better BibTeX 插件：https://retorque.re/zotero-better-bibtex/

#### 使用 Zotero

1. 在浏览器中打开论文页面（如 Google Scholar、CNKI）
2. 点击 Zotero Connector 图标，自动保存文献信息
3. 在 Zotero 中右键文献 → Export Item → 选择 BibLaTeX 格式
4. 将导出的内容粘贴到 `ref.bib` 文件中

### BibTeX 文件格式

`ref.bib` 文件示例：

```bibtex
% 期刊论文
@article{smith2020,
    author = {Smith, John and Wang, Li},
    title = {The Economics of Shirking},
    journal = {Journal of Labor Economics},
    year = {2020},
    volume = {38},
    number = {2},
    pages = {123--456},
}

% 书籍
@book{jones2019,
    author = {Jones, Mary},
    title = {Contract Theory},
    publisher = {MIT Press},
    year = {2019},
}

% 工作论文
@techreport{zhang2021,
    author = {Zhang, Wei},
    title = {Agency Problems in Chinese Firms},
    institution = {NBER},
    year = {2021},
    type = {Working Paper},
    number = {12345},
}
```

### 在论文中引用

```latex
% 作者在句中
\citet{smith2020} 发现...
% 输出: Smith and Wang (2020) 发现...

% 作者在括号中
这一结论已被证实 \citep{jones2019}。
% 输出: 这一结论已被证实 (Jones, 2019)。

% 多个引用
根据已有研究 \citep{smith2020, jones2019, zhang2021}...
% 输出: 根据已有研究 (Smith and Wang, 2020; Jones, 2019; Zhang, 2021)...
```

### 中英文参考文献分开管理

- 中文参考文献放在 `parts/zh/ref.bib`
- 英文参考文献放在 `parts/en/ref.bib`

两个文件可以有相同的内容，也可以不同。

---

## 图片和表格

### 添加图片

1. 将图片文件放在 `parts/zh/img/` 或 `parts/en/img/` 目录
2. 支持的格式：`.png`, `.jpg`, `.pdf`
3. 推荐使用 `.pdf` 格式（矢量图，清晰）

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\textwidth]{img/your-image.png}
    \caption{图片标题}
    \label{fig:your-label}
\end{figure}

% 引用图片
如图 \ref{fig:your-label} 所示...
```

### 添加表格

```latex
\begin{table}[htbp]
    \centering
    \caption{表格标题}
    \label{tab:your-label}
    \begin{tabular}{lcc}
        \toprule
        变量 & 均值 & 标准差 \\
        \midrule
        变量A & 1.23 & 0.45 \\
        变量B & 6.78 & 0.12 \\
        \bottomrule
    \end{tabular}
\end{table}

% 引用表格
如表 \ref{tab:your-label} 所示...
```

### 回归结果表格

推荐使用 Stata 的 `esttab` 或 R 的 `stargazer` 包直接导出 LaTeX 格式的回归表格。

---

## 数学公式

### 行内公式

```latex
根据模型设定，$y = \alpha + \beta x + \epsilon$，其中 $\epsilon$ 为误差项。
```

### 独立公式

```latex
\begin{equation}
    \max_{e} U(e) = w - c(e) - p \cdot F \cdot \mathbf{1}_{e < e_{min}}
    \label{eq:utility}
\end{equation}

由公式 \eqref{eq:utility} 可知...
```

### 公式录入工具

推荐使用 [Mathpix](https://mathpix.com/)：
1. 截图任意公式
2. 自动转换为 LaTeX 代码
3. 粘贴到论文中

---

## 分阶段提交说明

论文提交分为三个阶段，每个阶段需要提交不同版本：

### 阶段一：盲审 (Blind Review)

**时间**：一般在 4 月

**要求**：
- 隐藏学生姓名、学号
- 隐藏导师姓名
- 不包含致谢
- 不包含原创性声明

**编译命令**：

```bash
make blind
```

**提交文件**：`output/blind/thesis.pdf`

### 阶段二：答辩 (Defense)

**时间**：一般在 5 月

**要求**：
- 显示学生姓名、学号
- 隐藏导师姓名（有些学校要求）
- 不包含致谢
- 不包含原创性声明

**编译命令**：

```bash
make defense
```

**提交文件**：`output/defense/thesis.pdf`

### 阶段三：最终版 (Final)

**时间**：一般在 6 月

**要求**：
- 显示所有信息
- 包含致谢
- 包含原创性声明（需签字扫描）

**编译命令**：

```bash
make final
```

**提交文件**：`output/final/thesis.pdf`

### 一键编译三个版本

如果你想一次性生成三个版本：

```bash
make
```

这会依次编译盲审版、答辩版、最终版，全部放在 `output/` 目录下。

### 关于版权声明和原创性声明

#### 版权声明

1. 从学校门户系统下载 `版权声明.pdf`
2. 将文件放到 `pdf/版权声明.pdf`（替换原有文件）
3. 编译时会自动嵌入到封面部分

#### 原创性声明

1. 打印原创性声明页（可以先用模板生成一版，打印最后几页）
2. 手写签名、填写日期
3. 扫描为 PDF（或用手机扫描 App）
4. 将文件放到 `pdf/原创性声明.pdf`（替换原有文件）
5. 编译时会自动嵌入（仅最终版）

**注意**：盲审版和答辩版不会包含原创性声明，不用担心。

---

## 版本管理 (Git)

强烈建议使用 Git 管理你的论文，好处：
- 追踪每次修改
- 随时回退到之前的版本
- 备份到云端（GitHub/Gitee）
- 多设备同步

### 第一步：初始化 Git 仓库

```bash
cd ~/Documents/my-thesis
git init
git add .
git commit -m "初始化论文项目"
```

### 第二步：创建 GitHub 仓库

1. 注册 GitHub 账号：https://github.com/
2. 点击右上角 `+` → `New repository`
3. 填写仓库名（如 `my-thesis`）
4. **选择 Private（私有）**，不要让别人看到你的论文！
5. 点击 `Create repository`

### 第三步：推送到 GitHub

```bash
git remote add origin https://github.com/你的用户名/my-thesis.git
git branch -M main
git push -u origin main
```

### 日常使用

每次修改后：

```bash
git add .
git commit -m "完成第二章初稿"
git push
```

**提交信息建议**：
- `完成第一章初稿`
- `修改摘要`
- `添加回归表格`
- `根据导师意见修改第三章`

### 查看历史

```bash
git log --oneline
```

### 回退到之前的版本

```bash
# 查看历史
git log --oneline

# 回退到某个版本（只看，不改）
git checkout abc1234

# 回到最新版本
git checkout main
```

---

## 常见问题

### Q: 编译失败怎么办？

1. **先清理缓存**：

```bash
make cleanall
make
```

2. **查看错误信息**：

错误信息通常会告诉你哪个文件的哪一行有问题。

3. **常见错误**：
   - `Undefined control sequence`：命令拼写错误
   - `Missing $ inserted`：数学符号没放在 `$...$` 中
   - `File not found`：文件路径错误

### Q: 中文显示乱码？

确保你的文件保存为 **UTF-8** 编码。

VS Code 中：点击右下角的编码 → 选择 `Save with Encoding` → `UTF-8`

### Q: 参考文献不显示？

1. 确保 `ref.bib` 中的条目格式正确
2. 确保论文中有 `\citep{}` 或 `\citet{}` 引用
3. 运行 `make cleanall && make` 重新编译

### Q: 如何增加/减少章节？

编辑 `parts/zh/main.tex` 或 `parts/en/main.tex`：

```latex
% 添加新章节
\include{chap/chap7}

% 删除章节（注释掉）
% \include{chap/chap6}
```

### Q: 可以用 Overleaf 吗？

可以，但需要一些调整：
1. 将整个项目上传到 Overleaf
2. 设置编译器为 XeLaTeX
3. 可能需要手动处理多文件结构

本地编译体验更好，推荐使用本地环境。

### Q: 如何添加自己的 LaTeX 包？

在 `configs.tex` 文件末尾添加：

```latex
\usepackage{你需要的包}
```

### Q: 表格/图片太大放不下？

调整宽度参数：

```latex
% 图片
\includegraphics[width=0.6\textwidth]{...}  % 改小

% 表格可以用 adjustbox 或 resizebox
\usepackage{adjustbox}
\begin{adjustbox}{width=\textwidth}
    \begin{tabular}{...}
    ...
    \end{tabular}
\end{adjustbox}
```

---

## 必读附件

项目目录中有三个附件，**请务必仔细阅读**：

| 附件 | 内容 | 重要程度 |
|------|------|----------|
| 附件1：北大汇丰商学院毕业论文格式要求202503.docx | 最新的格式要求 | ⭐⭐⭐⭐⭐ |
| 附件2：北京大学研究生学位论文写作指南.pdf | 北大通用要求 | ⭐⭐⭐⭐ |
| 附件3：原模板说明.pdf | 原模板使用技巧 | ⭐⭐⭐ |

**特别注意**：
- 格式要求可能每年更新，以附件1为准
- 如果本模板与附件1有冲突，请联系学长更新模板
- 答辩前请再次核对格式要求

---

## 写作建议

### 时间规划

| 时间 | 任务 |
|------|------|
| 1-2 月 | 确定选题，收集文献 |
| 2-3 月 | 完成初稿 |
| 3-4 月 | 导师修改，准备盲审 |
| 4 月 | 盲审 |
| 5 月 | 根据意见修改，答辩 |
| 6 月 | 最终定稿，提交 |

### 写作技巧

1. **先搭框架，再填内容**：先写好每章的小标题
2. **每天写一点**：不要拖到最后
3. **及时备份**：用 Git，每天 commit
4. **导师沟通**：定期汇报进度，不要闭门造车

### 检查清单

提交前请检查：

- [ ] 封面信息正确（姓名、学号、导师、专业）
- [ ] 摘要中英文对应
- [ ] 关键词正确
- [ ] 目录页码正确
- [ ] 参考文献格式统一
- [ ] 图表编号连续
- [ ] 没有孤立的图表（图表要有引用）
- [ ] 致谢不包含导师姓名（盲审版/答辩版）
- [ ] 原创性声明已签字（最终版）
- [ ] PDF 文件大小合理（一般不超过 20MB）

---

## 获取帮助

1. **查阅本文档**：大部分问题这里都有答案
2. **搜索错误信息**：把错误信息复制到 Google/百度搜索
3. **询问 ChatGPT/Claude**：描述你的问题和错误信息
4. **联系学长**：如果以上都不能解决

---

## 致谢

本模板基于 [iofu728/pkuthss](https://www.overleaf.com/latex/templates/2022-peking-university-master-thesis-template-iofu728-pkuthss/rwfvbkpzydpf) 修改。

由 [知经 KNOWECON](https://knowecon.com) 维护。

如有问题，请联系学长。

---

祝毕业顺利！🎓

喵喵学长敬上
