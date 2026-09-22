## 说明

这是 incoPat 专利数据库检索式文档（`.incopat`）的 Vim 插件，用于：

- 识别 `.incopat` 文件为 `incoPatSearchCriteria` 文件类型；
- 高亮检索式中的字段代码、运算符、分类号、引号短语与注释；
- 提供检索式的整理（美化）、单行化、按 `or` 合并/拆行、粘贴检索要素等命令。

## 安装

把仓库目录加入 Vim 的 `runtimepath`（例如用 vim-plug / packer / lazy.nvim 之类的插件管理器），插件会自动加载：

```
ftdetect/incoPatSearchCriteria.vim    " *.incopat → filetype=incoPatSearchCriteria
ftplugin/incoPatSearchCriteria.vim    " 命令、映射与检索式整理函数
syntax/incoPatSearchCriteria.vim      " 语法高亮
```

## 支持的语法

| 语法 | 写法 | 高亮组 |
| --- | --- | --- |
| 布尔运算符 | `and` `or` `not` | `Keyword` |
| 可选运算符 | `(条件) OPT (可选要素)` | `Keyword` |
| 范围关键字 | `[20200101 to 20241231]` 中的 `to` | `Keyword` |
| 赋值/比较符 | `=` `>` `<` `>=` `<=` | `scOperator` |
| 邻近算符 | `(w)` `(n)` `(s)` `(sen)` `(p)`、`(0w)`~`(99w)`、`(0n)`~`(99n)` | `scConnector` |
| 频率算符 | `(nf)`，n 为 1~100 的整数，如 `(3f)`、`(100f)` | `scFrequency` |
| 字段代码 | `ti=` `ab=` `tiab=` `ipc=` `pd=` `r=` …（已知 474 个） | `scKEY` |
| 未知字段 | `foo=`（不在字段表白名单内） | `scUnknownKey` → `Error`（标红） |
| 语义检索 | `R=(...)` `RAD=(...)` `RPD=(...)` | `scKEY` |
| 专利分类号 | `F25B`、`A61K31/00`、`H04L12/28` | `scPC` / `scUC` |
| 公司树 | `TREE@"公司名"` | `scTreeAt` |
| 通配符 | `*` `?` `$` | `scDelimiter` |
| 引号短语 | `"精确匹配"` `'精确匹配'` | `scString` |
| 注释 | `# 行注释`（见下方说明） | `scComment` |

> **关于 `#`（重要）**：incoPat 官方系统中 `#N` 表示「引用第 N 条检索历史」，
> 例如 `#1 and TI=computer`；**官方并没有「注释」语法**（依据：官方前端 i18n 资源
> `https://www.incopat.com/resources/js/i18n/search.properties` 中的
> `search_searchHistory_...=可引用检索历史编号进行逻辑组配，例如：#1 and TI=computer`）。
> 本插件按使用习惯把整行 `# ...` 当注释高亮，与 dprint 格式化插件保持一致；
> 但如果要在检索式里使用检索历史引用，请注意 `#` 开头的行会被当作注释。

### 相对旧版官方语法的更新

incoPat 官方语法新增/调整了以下内容，本插件已同步适配：

1. **可选运算符 `OPT`**（新增）：`(条件) OPT (可选要素)`，优先级低于 `or`。
   - 高亮为 `Keyword`；
   - `BeautifySC` / `CopyOneLine` 会把它统一为小写 `opt` 并规范两侧空格。
2. **同句算符 `(sen)`**（新增，与 `(s)` 等价）：高亮为 `scConnector`。
3. **频率算符的取值范围是 1~100**（原先只认 1~2 位数字）：
   - `(100f)` 现在能正确高亮；
   - `(0f)`、`(101f)`、`(f)` **不是**合法频率算符，不会被高亮，可作为书写错误的提示。
4. **语义检索关键词 `R` / `RAD` / `RPD` 恒为大写**：`BeautifySC` / `CopyOneLine` 会自动把 `r=` 改写为 `R=`，与 dprint 格式化插件的输出保持一致。
5. **比较范围中的字段名现在会被高亮**：`(20110101<=pd<=20130101)` 中的 `pd` 会按 `scKEY` 高亮（旧版只认 `字段=` 写法）。
6. **邻近/频率算符两侧的空格会被规范为单个空格**：`空调   (2w)   蒸发器` → `空调 (2w) 蒸发器`。

### 字段名的识别方式

incoPat 官方词法并不使用字段白名单，只要「标识符 + 可选空格 + `=`」就构成字段表达式
（即 `foo=xxx` 里的 `foo` 在语法上是合法的字段名）。因此本插件分两层：

- `scUnknownKey`：通用匹配任意 `标识符 =`，**并在白名单命中时让位**给 `scKEY`；
  没被白名单命中的标识符会链接到 Vim 的 `Error` 高亮组，**标红提示拼写错误或尚未收录的新字段**。
- `scKEY`：474 个已知字段的白名单（来源见下）。

于是 `ti=` / `ti-cn=` / `ap-company-org-type=` 正常高亮，而 `foo=` 会标红。
如果 incoPat 新增了字段，把它补进 `syntax/incoPatSearchCriteria.vim` 里 `scKEY` 的列表即可消除标红。

> 注意：注释（`# ...`）和引号短语（`"a=b"`）内部的 `标识符=` **不会**被标红。

### 字段代码表来源

`syntax/incoPatSearchCriteria.vim` 里的 `scKEY` 白名单共 **474 个** = 官方《原始字段代码说明》
（`https://www.incopat.com/help/sysdoc/helpcode.html`，需登录）的 **468 个字段代码**
+ `R` / `RAD` / `RPD` 三个语义检索关键词（见官方《超级排序》帮助页，不在这张字段代码表内）
+ 3 个数据库兼容的旧字段（`APNORTT` / `AEENORTT` / `PATENTEENORTT`）。
白名单按官方字段表的顺序排列。字段名不区分大小写。

完整的官方字段表（字段代码 + 中英文名 + 检索样例）已整理成
[`docs/incopat-field-codes.md`](docs/incopat-field-codes.md)；
**核对规则与两组「页面上看不到 / 已证实不存在」的例外见
[`docs/field-code-notes.md`](docs/field-code-notes.md)——以后不要再单独去核实这些字段**。

> 官方帮助页 `https://www.incopat.com/help/sysdoc/principal.html` 与 `.../helpcode.html`
> 目前**已迁入登录墙之后**（未登录直接访问只会返回官网首页）。
> 检索规则方面的离线资料见 [`docs/incopat-official-syntax.md`](docs/incopat-official-syntax.md)，
> 但那份文档是 AI 从公开资料整理的，**其中的字段表已被证伪，不要使用**。

## 命令

| 命令 | 模式 | 说明 |
| --- | --- | --- |
| `:BeautifySC` | 范围/全文 | 整理检索式：字段名与布尔运算符小写、语义检索关键词大写、邻近/频率算符空格归一、规范括号、分类号大写 |
| `:CopyOneLine` | 可视/全文 | 整理并压成一行（去掉多余空白），复制到系统剪贴板 |
| `:JoinLinesWithOR` | 可视 | 把选中的若干行用 ` or ` 连成一行 |
| `:SplitLinesWithOR` | 可视 | 把选中行按 `or` 拆成多行并去重 |
| `:GetElements` | 可视/全文 | 抽出检索要素（去掉序号、方括号、圆括号）复制到剪贴板 |
| `:PasteListInClipboard` | 普通 | 把剪贴板中的一列检索要素规范化后粘到当前行下方 |
| `:FixSCinBracket` / `:FixSCinBracket!` | 普通 | 修正圆括号内的检索式（`!` 表示同时排序去重） |

对应的 `<Plug>` 映射：`<Plug>BeautifySC`、`<Plug>CopyOneLine`、`<Plug>JoinLinesWithOR`、
`<Plug>SplitLinesWithOR`、`<Plug>GetElements`、`<Plug>PasteListInClipboard`、
`<Plug>FixSCinBracket`、`<Plug>FixAndSortSCinBracket`。

## 输入法缩写

`ftplugin` 中为五笔和拼音输入法提供了运算符缩写（`巨`→`and`、`煌`→`or`、`刷业务`→`not`、
`安定`→`and`、`偶然`→`or`、`农田`→`not`），并会把全角括号 `（` `）` 替换为半角。

## 相关项目

- [dprint-plugin-incopat](https://github.com/CNIPA/dprint-plugin-incopat)：incoPat 检索式的 dprint
  格式化插件，本插件的语法规则与它保持一致。
