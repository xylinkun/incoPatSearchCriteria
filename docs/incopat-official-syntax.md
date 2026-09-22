# incoPat（合享智慧）专利检索式官方语法参考

> **整理日期（抓取日期）**：2026-09-22
> **整理范围**：incoPat 官方检索规则、算符定义、字段代码说明
> **重要说明**：本文中每一条信息都标注了来源。凡官方公网未能取得的内容，一律标注「**未获取到**」，不做推测性补全。少数由系统前端资源推断出的结论，均明确标注为「**由官方前端资源推断**」。

> ## ⚠️ 维护者更正（2026-09-22，实测，有数据库访问权限）
>
> 本文是 AI 从**公开资料**（培训手册 PDF + 前端 i18n 资源）整理的，**不是**官方文档原文。
> 经维护者在官方「原始字段代码说明」页（登录后可见）与数据库中实测，本文至少有三处需要更正，
> 均已在原处标注：
>
> | 位置 | 原文错误 | 更正 |
> | --- | --- | --- |
> | §14.2 | 把 `CL` 列为「权利要求」的字段代码 | **`CL` 不存在**。维护者在官方字段说明页与数据库中均查无此字段，实际不能使用；权利要求对应 `CLAIM`。该行是**从手册散文「权利要求是基本检索字段」推断出代码**的，属于编造。 |
> | §5.4 | 称「不能确认 incoPat 支持 `(sen)`」 | **错误**。`(sen)` 是 incoPat **旧的同句运算符**，与 `(s)` 完全同义；官方网页已不再列出，但**数据库仍然支持**。 |
> | §15.3 / §16 | 重复了上述两条错误结论 | 同上。 |
>
> **使用建议**：§14 的字段表**不要**当作权威清单使用——请以登录后的官方
> [原始字段代码说明](https://www.incopat.com/help/sysdoc/helpcode.html) 为准；
> 本仓库插件所用的 462 条白名单来自 `dprint-plugin-incopat` 的 `src/parser/fields.rs`，
> 与本文无关，未受这些错误影响。

---

## 0. 首要结论：用户指定的两个官方网址已失效

任务指定的两个目标网址，经实测**已不再提供文档正文**：

| 网址 | 实测结果（2026-09-22） |
| --- | --- |
| `https://www.incopat.com/help/sysdoc/principal.html` | HTTP 200，但返回的是**官网首页**（66497 字节的登录/首页模板，`<title>` 为「incoPat 可信好用的全球专利数据库…」），并非检索规则文档 |
| `https://www.incopat.com/help/sysdoc/helpcode.html` | 同上，返回官网首页 |

**验证方法与排除结论：**

- 服务器为 `openresty`，对 `/help/*` 下**任意**路径都返回同一份 66497 字节的首页兜底页（catch-all fallback），包括 `.json`、无扩展名、`index.html`、`/helpCenter`、`/learningCenter/init` 等。
- 使用 headless Edge（`--headless=new --dump-dom`）渲染 `principal.html` 与 `helpcode.html` 后，DOM 中**不含**任何检索规则内容（关键词 `Nw`、`位置算符`、`字段代码`、`TREE@`、`OPT` 命中数均为 0，正文即首页）。因此**不是**「SPA 动态加载」，而是该页面在公网已被移除/迁入登录后系统。
- `/resources/*` 是真实静态目录（不存在的文件返回真正的 404 / 3849 字节），而 `/help/*` 是应用路由兜底 —— 说明帮助文档已不在公网静态目录中。
- 反证：`https://www.incopat.com/help/sysdoc/patentKing` 是**仍然存在**的真实页面（4197 字节，`<title>专利大王</title>`），说明 `/help/sysdoc/` 目录本身仍在，只是文档类页面被下线。

**官方培训手册中记录的原帮助中心页面清单**（来源：incoPat V6.0 使用技巧培训手册 2026 Q1，附录「系统规则介绍」表，见 `https://lib.neepu.edu.cn/libdownload/incoPatV6.0shouhoupeixunshouce-zhuanyeban.pdf`）：

| 页面 | 说明 | 原网址 |
| --- | --- | --- |
| 更新日志 | 了解系统功能更新 | `https://www.incopat.com/help/sysdoc/journal.html` |
| 检索规则 | 系统不同运算符的检索规则 | `https://www.incopat.com/help/sysdoc/principal.html` |
| 数据范围 | 查看系统收录的数据范围 | `https://www.incopat.com/help/sysdoc/getPdDate...` |
| 原始字段代码说明 | 数据库支持的检索字段及释义 | `https://www.incopat.com/help/sysdoc/helpcode.html` |
| 同族字段代码说明 | 同族数据库支持的检索字段及释义 | `https://www.incopat.com/help/sysdoc/helpcodeKin.html` |
| 号码格式说明 | 不同国家的号码显示规则 | `https://www.incopat.com/help/sysdoc/formatcode.html` |
| 常见问题 | 常见问题答疑 | `https://www.incopat.com/help/sysdoc/FAQ1.1.html` |

上述页面**现已全部返回首页兜底页**。据官方《Incopat 使用指引》（来源：`https://www.gzpc.org.cn/f/fileManager/readFile/e68e55d7b0b74c91b3fe11d3532d8a9e`），这些内容现在需要**登录系统后**通过「右上角 帮助中心 → 检索规则 / 原始字段代码说明」查看，即**已迁入登录墙后**，公网无法直接抓取。

**替代来源与补救措施（本次实际采用）：**

1. **incoPat 官方培训手册 PDF**（北京合享智慧科技有限公司编写，含完整「2.4 检索规则」章节）——本文件第 1–8 节的主要来源。
2. **incoPat 线上系统前端资源**（无需登录即可访问的官方服务器静态文件）
   `https://www.incopat.com/resources/js/i18n/search.properties`（227,922 字节，简体中文）
   `https://www.incopat.com/resources/js/i18n/search_en.properties`（179,180 字节，英文）
   ——这是 incoPat 前端用于**实时校验检索式并弹出错误提示**的官方文案库，因此它精确记录了系统**实际支持/不支持**的算符与语法限制。本文件第 6、7、8、9、10、12 节中「系统校验规则」条目均来自此文件（标注为「由官方前端资源推断/佐证」）。
3. 该 `search.properties` 同时包含官方字段标识 → 中文名称映射（550 条），见第 14 节。

---

## 1. 信息来源清单

| 编号 | 来源 | 类型 | 抓取日期 | 说明 |
| --- | --- | --- | --- | --- |
| S1 | `https://lib.neepu.edu.cn/libdownload/incoPatV6.0shouhoupeixunshouce-zhuanyeban.pdf` | incoPat V6.0 使用技巧培训手册（**2026 年 Q1**，最新版） | 2026-09-22 | 官方（北京合享智慧科技有限公司）编写；含 2.4.1–2.4.9 全部检索规则 |
| S2 | `http://iae.cas.cn/gb2019/xwzx_156509/tzgg_156516/202503/P020250314563279877594.pdf` | incoPat V6.0 使用技巧培训手册（**2024 年 Q4**） | 2026-09-22 | 官方手册，与 S1 内容基本一致 |
| S3 | `https://library.fudan.edu.cn/_upload/article/files/cf/82/fcfc67e24105bf7964d71f4b1ce3/b2cce8cb-5e67-4eda-807e-63a52b795f6b.pdf` | incoPat V6.0 使用技巧培训手册（2020 年 12 月） | 2026-09-22 | 旧版，用于对比语法变更 |
| S4 | `https://lib.ustc.edu.cn/wp-content/uploads/2019/07/incoPat-使用手册.pdf` | incoPat V6.0 使用技巧培训手册（2019 年 5 月） | 2026-09-22 | 最旧版，用于对比语法变更 |
| S5 | `https://www.lib.szu.edu.cn/sites/szulib/files/er/incoPat 培训手册_0.pdf` | incoPat 培训手册（深圳大学图书馆） | 2026-09-22 | 与 S3 同期内容 |
| S6 | `https://www.incopat.com/resources/js/i18n/search.properties` | **incoPat 官方前端 i18n 资源**（简体中文，227,922 字节） | 2026-09-22 | 系统检索式校验提示文案 + 550 条字段标识表 |
| S7 | `https://www.incopat.com/resources/js/i18n/search_en.properties` | incoPat 官方前端 i18n 资源（英文，179,180 字节） | 2026-09-22 | 英文对照 |
| S8 | `https://www.gzpc.org.cn/f/fileManager/readFile/e68e55d7b0b74c91b3fe11d3532d8a9e` | 《Incopat 使用指引》（贵州理工学院图书馆） | 2026-09-22 | 帮助中心菜单结构与登录路径 |
| S9 | `https://www.incopat.com/help/sysdoc/patentKing` | incoPat 官网现存页面 | 2026-09-22 | 证实 `/help/sysdoc/` 目录仍在 |
| S10 | `https://clarivate.libguides.com/ld.php?content_id=67707292` | incoPat 旗舰版介绍（Clarivate LibGuides） | 2026-09-22 | 旗舰版字段扩展背景 |

**未能访问的来源（明确记录）：**

- `web.archive.org` / `archive.org` / `timetravel.mementoweb.org` / `archive.ph` —— 本机网络环境**无法连通**（连接超时，curl 退出码 28 / 000），无法取得 `principal.html`、`helpcode.html` 的历史存档。
- `https://www.incopat.com/help/sysdoc/principal.html`、`helpcode.html` —— 已失效（见第 0 节）。
- `https://www.patentguru.com/cn/help/code`（第三方「字段代码说明」）—— 有反爬校验，headless 渲染只得到「正在进入…首次请稍候」的拦截页，**未能取得内容**。
- 部分高校手册下载链接失效（如 `my.sues.edu.cn`、`lib.ustb.edu.cn` 返回 404 / 连接失败）。

---

## 2. 检索式基础规则（其他规则）

> 来源：**S1**（incoPat V6.0 使用技巧培训手册 2026 Q1，§2.4.9「其他规则」）；文字为原文摘录。

1. 检索式**不区分大小写**和中英文输入法，长度建议不要超过 **2 万字符**。
2. 少数号码格式与其他系统不同，如号码检索出现问题，可以参考「帮助中心 ->> 号码格式说明」进行号码格式修改，或咨询客服人员。
3. **英文词组需要用双引号引起**，否则系统会把空格默认为 `AND` 逻辑。
   - 例如，如果希望在标题中检索词组 `electronic vehicle`，应写成 `TI=("electronic vehicle")`；
   - 如写成 `TI=(electronic vehicle)`，会被解析为 `TI=(electronic and vehicle)`。
4. **括号需要成对使用**，并且注意使用位置。
5. `"."`、`"/"`、`"-"`、`"&"` 等符号的处理规则：
   - 当 `"."` 位于**数字与数字之间**，或**字母与字母之间**时，系统不会对该符号进行特殊处理。例如检索式 `AP=(amazon.com)` 中的 `amazon.com` 会被解析成**一个单词**，因此与 `AP=(amazon com)` 的结果不同。
   - 当 `"/"` 位于数字与字母之间时，以及 `"-"`、`"&"` 等其他符号位于数字或字母间时，系统会将这些符号**处理为空格**。例如检索式 `TI=("USB KEY")`、`TI=(USB-KEY)`、`TI=(USB&KEY)` 的结果一致。
   - 当 `"."` 位于**数字与字母之间**时，系统会将数字与字母之间相隔一位的所有形式都检索出来，例如 `No.6201262`、`No,6201262`、`No、6201262`。
   - 当检索条件中包含**汉字**时，系统会将这些符号处理为**空格**；由于中文检索会自动忽略空格，因此检索式 `IN=(R 保罗)`、`IN=(R-保罗)` 或 `IN=("R 保罗")` 的结果一致；当遇到 `"."` 时，会将相隔一位的所有形式都检索出来，例如 `IN=(R.保罗)`、`IN=(R,保罗)`、`IN=(R、保罗)`。

**官方前端校验提示（S6，佐证上述规则）：**

| 官方文案 key | 中文文案 |
| --- | --- |
| `solrResultJS_yiwaikongge` | 发现意外空格 |
| `solrResultJS_weifaxianpeiduikuohao` | 未发现配对括号 |
| `solrResultJS_kuohaneibunengweikong` | 括号内，值不能为空 |
| `solrResultJS_faxianchongfudengyu` | 发现有重复的 = |
| `solrResultJS_bunengyidengyujiewei` | 不能以「=」为结尾 |
| `solrResultJS_ziduanbuzhicixinghaokaitou` | 字段不支持以 * 开头 |
| `solrResultJS_ziduanneibunengqiantaoziduan` | 字段内不能嵌套字段 |
| `solrResultJS_baohanziduanhuoluojiyunsuanfu` | 引号中的字段或者运算符，会被解析为普通字符 |
| `solrResultJS_buhuidangzuoluojiyongsuanfushiyong` | 不会当作逻辑符使用 |
| `search_min_tongshijiansuogongshangshuzhongxiajimingcheng` | TREE@ 算符，同时检索其在 incoPat 工商树中的下级名称 |
| `advanced_jiansuoshizhongzanbuzhichiyujiansuo` | 检索式中出现 W/N，(S)，(P)，R，RAD，RPD 时，暂不支持预检索 |

---

## 3. 布尔算符（AND / OR / NOT）

> 来源：**S1** §2.4.1「逻辑运算符」原文；优先级描述同见 S2/S3/S4/S5。

incoPat 支持三种逻辑运算符：

- **逻辑与 —— `AND`**：检索结果需**同时满足**「AND」连接的两个条件。
- **逻辑或 —— `OR`**：检索结果**只需满足**「OR」连接的两个条件之一。
- **逻辑非 —— `NOT`**：检索结果需**满足「NOT」连接的前一个条件，而不满足后一个条件**。

**优先级：`NOT` > `AND` > `OR`**，可以使用**括号**区分优先级。

原文示例：

- 逻辑检索式 `TI=(A OR B AND C)`：首先会运算 `B AND C` 的结果，然后再与 `A` 进行 `OR` 的运算。
- 逻辑检索式 `TI=((A OR B) AND C)`：首先会运算 `A OR B` 的结果，然后再与 `C` 进行 `AND` 的运算。

**官方前端校验提示（S6）：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_luojiyunsuanfuyongfacuowu` | 逻辑运算符用法错误 |
| `solrResultJS_luojiyunsuanfubunenglianyong` | 逻辑符号不能连用 |
| `solrResultJS_bunengyiluojifukaitou` | 不能以逻辑运算符为开头 |
| `solrResultJS_bunengyiluojifujiewei` | 不能以逻辑运算符为结尾 |

---

## 4. 范围算符 `to` 与比较算符 `<` `<=` `>` `>=`

> 来源：**S1** §2.4.4「范围检索」原文。

如果需要检索**时间段**或者**数字范围**，可以使用范围检索。

### 4.1 `to` 范围算符

范围检索用 `to` 连接日期或数字的起始点（**`to` 前后日期、数字格式应保持一致**），**外层需写出中括号 `[ ]`**。

（原文中「表 2-2 范围检索式示例」在 PDF 中为图片，**具体表格内容未获取到**。官方手册正文仅明确了语法结构 `[a to b]`。）

官方前端校验对 `to` 的提示原文（S6）：

| key | 中文文案 |
| --- | --- |
| `solrResultJS_geshicuowushiyongto` | 格式错误，用"TO"连接左右范围边界值，形成类似于 `[a to b]` 的检索式 |
| `solrResultJS_qingyongto` | 请用"TO"连接 |
| `solrResultJS_shijianfanweibuyizhi` | 时间范围格式不一致 |
| `solrResultJS_jiesuriqidayuqishiriqi` | 结束日期应大于起始日期 |
| `solrResultJS_jiesuzhidayuqishizhi` | 结束值应大于起始值 |

### 4.2 比较算符（范围运算符）

除了用 `to` 连接之外，范围检索还可以使用**范围运算符**，用范围运算符连接左右范围边界值，运算符有 `"<"`、`"<="`、`">"`、`">="` **四种**，形成类似于 `(a<=x<=b)` 的检索式。

**原文示例**：检索 2011 年 1 月 1 日至 2013 年 1 月 1 日公开的专利，检索式为：

```
(20110101<=pd<=20130101)
```

**使用范围运算符时需要注意（原文）：**

- **时间类型**，需要使用 **4 位、6 位、8 位**，检索条件为某一范围时**前后格式需要统一**。
- **数值类型**，需要使用**非负整数**。
- 使用范围运算符时，**左右必须使用括号**。

**官方前端校验提示（S6）：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_fanweiyunsuanfuqueshaozuoyuankuohao` | 范围运算符缺少圆括号 |
| `solrResultJS_fanweiyunsuanfuhaoyizhi` | 范围运算符号必须一致 |
| `solrResultJS_gaiziduanbuzhichifanwei` | 该字段有可能不支持范围运算 |
| `solrResultJS_bixuweishuzhi` | 必须为数值 |
| `solrResultJS_bixudayuqishizhifanwei2` | 必须大于起始值，并且范围差值不能小于 2 |
| `solrResultJS_bixuxiaoyuqishizhifanwei2` | 必须小于起始值，并且范围差值不能小于 2 |
| `solrResultJS_zhibunengweifushu` | 值不能为负数 |
| `solrResultJS_nianfenyouwu1700` | 年份输入有误,应在 1700 之后 |
| `solrResultJS_yuefen1_12` | 月份应该在 1-12 之间 |

---

## 5. 位置 / 邻近算符

> 来源：**S1** §2.4.2「位置符」原文。

如果需要一个字段中同时包含两个关键词，并且两者的距离不是很远的话，可以使用位置符来实现。

**incoPat 目前支持 2 种位置符，分别为有序位置符 `(w)` 和无序位置符 `(n)`。**

**表 2-1 位置符的写法示例（原文）：**

| 类型 | 符号 | 介入字 / 单词数 | 示例 |
| --- | --- | --- | --- |
| 有序 | `(w)` | 1-99 | `手机(w)电池`，「手机」需位于「电池」之前，并且相隔 **0-1 个字**。 |
| 无序 | `(n)` | 1-99 | `car(5w)engine`，`car` 需位于 `engine` 之前，并且相隔 **0-5 个单词**。 |
| | | | `手机(9n)电池`，「手机」与「电池」的位置无前后要求，可相隔 **0-9 个字**。 |
| | | | `car(5n)engine`，`car` 与 `engine` 的位置无前后要求，可相隔 **0-5 个单词**。 |

> 说明：原文表格将「有序 / 无序」两行的示例合并排版，上表按语义拆分对齐。核心事实是：
> **`(w)` = 有序（前者必须在后者之前）**，**`(n)` = 无序（前后不限）**；数字 N 的范围是 **0–99**（官方前端校验文案：`solrResultJS_0_9zhijian` = 「0~99 之间」）；中文按**字**计数，英文按**单词**计数。

**关于 `(Nw)` / `(Nn)` 写法**：官方文档中的规范写法是 **`(数字w)` / `(数字n)`**，例如 `car(5w)engine`、`手机(9n)电池`。用户手册中的 1 表示 N；当 N 省略时写作 `(w)` / `(n)`，此时按「相隔 0-1」处理（见上表首行 `手机(w)电池` 示例）。即 **`(Nw)` ≡ `(w)` 带数字参数形式**。

**位置符的其他使用及解析规则（原文）：**

- 位置符**可以与逻辑符嵌套使用**，例如 `(A or B)(w)(C or D)`，系统会解析为 `A(w)C or A(w)D or B(w)C or B(w)D`。
- 位置符**可以连用**，例如 `A(2n)B(3n)C`。
- **目前尚不支持位置算符的嵌套使用**，如不支持检索 `TI=(car(5w)(electronic(3n)vehicle$))`。

**官方前端校验提示（S6）：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_weizhiyunsuanfu` | 位置运算符 |
| `solrResultJS_0_9zhijian` | 0~99 之间 |
| `solrResultJS_xitongbuzhichiweizhiyunsuanfuqiantao` | 系统不支持位置算符的嵌套使用 |
| `solrResultJS_xitongbuzhichiweizhiyunsuanfuheziduanqiantao` | 系统不支持位置算符和字段嵌套使用 |

### 5.1 同句算符 `(s)`

> 来源：**S1** §2.4.5「同句算符」原文。

如果需要检索一个**句子**中同时包含两个及以上关键词，可以使用同句算符。
incoPat 的同句算符用 **`(s)`** 表示，对指定的字段执行同句检索的操作。

- 同句算符的**优先级高于位置运算符和逻辑运算符**。
- 同句算符可以**在中文和英文中使用**，并且**可以连用**。例如 `A(s)B(s)C`。
- 同句算符**不支持**和位置算符（W/N）连用，例如 `des=(粉碎效果(s)粉碎刀具(12w)轨迹)`。
- 同句算符**不支持**和截词符（? * $）连用，例如 `des=(粉?效果(s)粉碎*具)`。

### 5.2 同段算符 `(p)`

> 来源：**S1** §2.4.6「同段算符」原文。

如果需要检索一个**段落**中同时包含两个及以上关键词，可以使用同段算符。
incoPat 的同段算符用 **`(P)`** 表示，对指定的字段执行同段检索的操作。

- 同段算符的**优先级高于同句算符、位置运算符和逻辑运算符**。
- 同段算符**仅限在中国专利中使用**，并且**可以连用**。例如 `A(p)B(p)C`。
- 同段算符**不支持**和位置算符（W/N）连用，例如 `des=(粉碎效果(p)粉碎刀具(12w)轨迹)`。
- 同段算符**不支持**和截词符（? * $）连用，例如 `des=(粉?效果(p)粉碎*具)`。
- 同段算符**不支持**和逻辑运算符 `not` 连用，例如 `des=((粉碎刀具 not 延长)(p)运动轨迹)`。
- **同句/同段算符支持和位置算符嵌套使用，支持和 `not` 连用，注意 `not` 不能作为 (S/P) 的两侧的检索要素中的内容。**

**官方前端校验提示（S6）：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_tongjuyunsuanfu` | 同句运算符 |
| `solrResultJS_tongduanyunsuanfu` | 同段运算符 |
| `solrResultJS_tongjuyunsuanfuyongfacuowu` | 同句运算符用法错误 |
| `solrResultJS_tongduanyunsuanfuyongfacuowu` | 同段运算符用法错误 |
| `solrResultJS_tongjuhuotongduanbunengtongluojinotshiyong` | 同句或同段运算符不能与逻辑运算符 not 同时使用 |
| `solrResultJS_buzhichijiechifulianyong` | 不支持和截词符（?/*/$）连用 |

### 5.3 位置算符优先级小结

由上述原文可归纳（**官方明确表述**）：

```
NOT  <  AND  <  OR          （逻辑算符之间：NOT 最高）
位置符 (w)/(n)  高于  逻辑运算符
同句符 (s)      高于  位置运算符和逻辑运算符
同段符 (p)      高于  同句运算符、位置运算符和逻辑运算符
```

即优先级（由高到低）：**`(p)` > `(s)` > `(w)`/`(n)` > `NOT` > `AND` > `OR`**。

### 5.4 关于 `(sen)`

> **⚠️ 本节原结论已作废，以下是更正后的内容（2026-09-22，维护者实测确认）**

`(sen)` 是 incoPat **旧的同句运算符**，与 `(s)` **语义完全相同**（`sen` = sentence）。
它已**不再出现在官方网页的说明中**，但**数据库本身仍然支持**该写法。

因此本仓库的 Vim 插件与 dprint 格式化插件都**保留**对 `(sen)` 的支持，按 `scConnector` 高亮。

<details>
<summary>原（错误的）结论，保留备查</summary>

> **未获取到。** 在 incoPat 官方手册（S1–S5）、官方前端资源（S6/S7）以及本次可及的全部资料中，
> **均未出现 `(sen)` 算符**……`(sen)` 是其他专利检索系统（如 STN / Orbit 等）中常见的
> 「同句」算符写法，**不能确认 incoPat 支持 `(sen)`**。

**错在哪**：把「公开资料里查不到」错当成了「系统不支持」。它是**已从文档中撤下的旧算符**，
公开手册与前端 i18n 自然都不会收录，但数据库仍在兼容。
</details>

---

## 6. 频率算符 `(Nf)`

> 来源：**S6**（incoPat 官方前端 i18n 资源，`search.properties`）—— 由官方前端资源推断/佐证。

官方系统校验文案原文：

| key | 中文文案 |
| --- | --- |
| `solrResultJS_pinlv` | 频率算符(nf)，限定关键词在该字段中出现频率≥n |
| `solrResultJS_pinlvfanzhi` | 1~100 之间 |
| `solrResultJS_geshicuowuyinggaiwei` | 格式错误，应该为 `（FIELD < NUM）` |
| `solrResultJS_guanjianci2550` | 关键词不超过 50 个字符(25 个中文字) |

**由此可确定的规则：**

- 写法：**`(nf)`**，其中 `n` 为频率下限；官方给出的通用格式提示为 **`（FIELD < NUM）`**。
- 语义：**限定关键词在该字段中出现频率 ≥ n**。
- `n` 的**取值范围：1~100**。
- 关键词长度上限：**不超过 50 个字符（25 个中文字）**。

**频率算符的嵌套/组合限制（原文文案，全部为「不支持」）：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_pinlvziduanbuzhichiR` | 系统不支持频率算符与 R、RAD、RPD 字段同时使用 |
| `solrResultJS_xitongbuzhichitongju` | 系统不支持频率算符与同句算符嵌套使用 |
| `solrResultJS_xitongbuzhichitongduan` | 系统不支持频率算符与同段算符嵌套使用 |
| `solrResultJS_xitongbuzhichiweisuanfu` | 系统不支持频率算符与位置算符嵌套使用 |
| `solrResultJS_xitongbuzhichiziduan` | 系统不支持频率算符与字段嵌套使用 |
| `solrResultJS_xitongbuzhichibiaodashi` | 系统不支持频率算符与表达式嵌套使用 |
| `solrResultJS_xitongbuzhichiqiantao` | 频率算符不支持嵌套使用 |

> 注：官方培训手册 S1 的 §2.4（检索规则）章节**未单独设「频率算符」小节**（该章只有逻辑运算符、位置符、截词符、范围检索、同句算符、同段算符、超级排序、TREE@、其他规则）。频率算符的信息来自官方前端校验文案。**具体检索示例原文未获取到。**

---

## 7. 可选算符 `OPT`

> 来源：**S6**（incoPat 官方前端 i18n 资源，`search.properties`）—— 由官方前端资源推断/佐证。

官方系统校验文案原文（`可选运算符` 即 `OPT`）：

| key | 中文文案 |
| --- | --- |
| `solrResultJS_kuanxuanyunsuanfu` | 可选运算符 |
| `solrResultJS_kuanxuanyunsuanfuxiandinghoumian` | **可选算符只能用于限定在布尔检索后面** |
| `solrResultJS_kuanxuanyunsuanfuzhichimowei` | 可选运算符后面缺少布尔检索式 |
| `solrResultJS_kuanxuanyunsuanfuhoumkuohao` | **可选运算符后的内容用括号包起来** |
| `solrResultJS_kuanxuanyunsuanfuOR` | **可选运算符内仅支持 OR 运算** |
| `solrResultJS_buzhichihunheR` | **可选算符不支持和 R 同时存在** |
| `solrResultJS_kuanxuanyunsuanfuOnlyOne` | **仅支持一个可选运算符** |
| `solrResultJS_buzhichiyunsuanfulianyong` | **可选运算符不能和其他运算符连用** |

**由此可确定的规则：**

- 可选算符 `OPT` 用于「放宽/可选」检索：括号内为**可选**条件，结果**不强制**包含。
- 位置限制：只能出现在**布尔检索式之后**（用于限定其前面的布尔检索）。
- 语法：`OPT` 后面的内容**必须用括号包起来**。
- 括号内**仅支持 `OR` 运算**。
- **仅支持一个 `OPT`**（不能出现多个）。
- **不能与其他运算符连用**。
- **不能与 `R` 同时存在**。

> 官方培训手册 S1–S5 的 §2.4 章节**未收录 OPT 算符**，因此 **`OPT` 的原文示例、正式定义表述未获取到**；以上为官方前端校验逻辑所反映的规则。

---

## 8. 通配符 / 截词符

> 来源：**S1** §2.4.3「截词符」原文。

由于英文单词可能存在不同拼写方法或变形形式（如单复数、不同时态等），编写英文检索式时为了保证查全率需要全部列出，但是可能会花费较多时间。为了快速编写检索式，可以使用截词符来进行单词或者数字的模糊检索。

**incoPat 提供了三种截词符，分别为 `$`、`?` 和 `*`**，使用方法及示例如下（原文）：

| 符号 | 官方定义 | 官方示例 | 检索结果 |
| --- | --- | --- | --- |
| **`$`** | 代表 **0-1 个字符** | `car$` 表示字母 `r` 的后方可存在 0 个或者 1 个字母 | 可检索出 `car`、`cars`、`card` 等单词；`12$` 可检索出 `12`、`120`、`121` 等数字 |
| **`?`** | 代表 **1 个字符** | `car?` 表示字母 `r` 的后方存在一个字母 | 可检索出 `cars`、`card` 等单词 |
| **`*`** | 代表 **0-n 个字符** | `car*` 表示字母 `r` 的后方可存在任意数量的字母 | 可检索出 `car`、`cars`、`cards` 等单词 |

**此外，使用截词符时需要注意（原文）：**

- **截词符仅限于单个英文单词内部和数字中使用。**

**官方前端校验提示（S6）：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_buzhichijiechifulianyong` | 不支持和截词符（?/*/$）连用（针对同句/同段算符） |
| `solrResultJS_ziduanbuzhicixinghaokaitou` | 字段不支持以 `*` 开头 |
| `solrResultJS_zhibunengweixing` | 值不能为 `*` |

### 8.1 关于 `#` 和 `!`

- **`#`**：**不是通配符/截词符**。incoPat 中 `#` 用于**引用检索历史编号**（见第 10 节）。
- **`!`**：在 incoPat 官方手册（S1–S5）与官方前端资源（S6/S7）中**均未出现**，**未获取到** `!` 作为通配符的任何官方定义。incoPat 官方明确的截词符**只有 `$`、`?`、`*` 三种**。

---

## 9. 单引号 `'...'` 与双引号 `"..."` 的区别

> 来源：**S1** §2.4.9 及 **S6**。

**已获取到的官方定义（双引号）：**

- **英文词组需要用双引号引起**，否则系统会把空格默认为「AND」逻辑。
  例如，如果希望在标题中检索词组 `electronic vehicle`，应写成 `TI=("electronic vehicle")`；
  如写成 `TI=(electronic vehicle)`，会被解析为 `TI=(electronic and vehicle)`。
- `TREE@` 算符**所连接的机构名称必须用双引号引用**（见第 12 节），例如 `ap=(TREE@"清华大学")`。
- 引号内**值不能为空**（`solrResultJS_yinhaoneibunengweikong`：引号内，值不能为空）。
- **双引号必须成对**（`solrResultJS_suanyinhaobuchengdui`：双引号不成对）。
- **引号中的字段或者运算符，会被解析为普通字符**（`solrResultJS_baohanziduanhuoluojiyunsuanfu`）。

**关于单引号 `'...'`：**

**未获取到。** incoPat 官方手册（S1–S5）与官方前端资源（S6/S7）中**均未出现单引号的用法说明**，系统的引号校验文案只提到「双引号」（`双引号不成对`）。因此**无法确认 incoPat 支持单引号**，也无法确认单引号与双引号有何语义差异。**不做推测。**

---

## 10. 方括号 `[...]` 的作用

**已获取到的官方用法（唯一确证）：**

- **范围检索**：范围检索用 `to` 连接日期或数字的起始点，**外层需写出中括号 `[ ]`**。
  官方前端校验原文：`格式错误，用"TO"连接左右范围边界值，形成类似于 [a to b] 的检索式`。

**其他用途：**

**未获取到。** 在官方手册（S1–S5）与官方前端资源（S6/S7）中，**中括号 `[ ]` 仅出现在范围检索 `[a to b]` 的语境中**，未发现方括号用于其他目的（如字段别名、注释、集合运算等）的官方说明。**不做推测。**

---

## 11. 注释语法（`#`）

**重要更正：在 incoPat 中，`#` 不是注释符号，而是「检索历史编号引用」符号。**

> 来源：**S6**（官方前端 i18n，`search.properties` / `search_en.properties`）

官方原文（中文）：

```
search_searchHistory_keyinyongjiansuolishi=可引用检索历史编号进行逻辑组配，例如：#1 and TI=computer
searchCommonJS_keyinyongjiansuolishibianhaojinxingluojizupei=可引用检索历史编号进行逻辑组配，例如：#1 and TI=computer
```

官方原文（英文，S7）：

```
searchCommonJS_keyinyongjiansuolishibianhaojinxingluojizupei=Could use search history serial number to do logical combination,e.g.#1 and TI=computer
search_searchHistory_keyinyongjiansuolishi=Use search history number to do logical merger. e.g. #1 and TI=computer
```

**结论：**

- **`#` 用于引用检索历史中的检索式编号**，例如 `#1 and TI=computer`（把历史第 1 条检索式与当前条件做 AND 组配）。此语法同时为「块检索」功能所依赖（官方手册 S1 §2.1.1 描述：点击检索式列表中的检索式，**其序号会自动添加到检索式输入框中**，从而实现多条检索式块之间的编辑与逻辑运算）。
- 官方还提供「执行多检索式」按钮（官方文案：`您输入了多个检索式，请点击"执行多检索式"按钮进行检索`）。
- **incoPat 的注释语法：未获取到。** 官方手册与官方前端资源中**均未出现**以 `#` 或其他符号作为「注释」的说明。`#` 在此系统中承担的是检索历史引用功能，**不应理解为注释**。

---

## 12. 语义检索字段 `R` / `RAD` / `RPD`（超级排序）

> 来源：**S1** §2.4.7「超级排序」原文。

incoPat 支持**超级排序 `R`** 与表格检索一同使用：在高级检索的检索框输入检索条件，同时在超级排序的检索框内输入公开（公告）号或者关键词、语句、段落、篇章等进行检索，**检索结果会自动按照与输入内容的相似度进行排序**。

**`R` 的规则（原文）：**

- incoPat 支持在高级检索指令框内直接输入检索条件并按照相似度进行排序。
- **`R` 的位置只能在检索式的开头或者结尾。**
- **多个技术同时参与超级排序时，用 `|` 分隔。**

原文示例：

```
R=(CN101850473B) AND (TIAB=(发动机))
(TIAB=(发动机)) AND R=(CN101850473B|CN1872361B|引擎)
```

**`RAD`（原文）：**

- `RAD` 检索的是**申请日小于**指定专利的专利，且检索结果**按该专利的相似度降序展示**；
- 有多个号码时，**按第一个号码的申请日**作为时间限定条件。

原文示例：

```
RAD=(CN1325248C) AND TI=(层压板)
RAD=(CN1325248C | CN110525013A) AND TI=(层压板)
```

**`RPD`（原文）：**

- `RPD` 检索的是**公开（公告）日小于**指定专利的专利，且检索结果**按该专利的相似度降序展示**；
- 有多个号码时，**按第一个号码的公开日**作为时间限定条件。

原文示例：

```
RPD=(CN1325248C) AND TI=(层压板)
RPD=(CN1325248C | CN110525013A) AND TI=(层压板)
```

**官方前端校验提示（S6），补充的硬性规则：**

| key | 中文文案 |
| --- | --- |
| `solrResultJS_yuyiyunsuanfuzhinengkaitouhuojiewei` | **语义运算符只能出现在检索式的开头或结尾** |
| `solrResultJS_yuyisuanfuzhibixuyoukuohao` | **语义算符的值必须带有括号** |
| `solrResultJS_yuyiqianhoulianjieAND` | **语义算符前后只能连接逻辑运算符 AND** |
| `solrResultJS_pinlvziduanbuzhichiR` | 系统不支持频率算符与 R、RAD、RPD 字段同时使用 |
| `solrResultJS_buzhichihunheR` | 可选算符不支持和 R 同时存在 |
| `solrResultJS_yinggaiweipnhuoguanjianci` | 应该为 PN 号或者关键词 |
| `advanced_jiansuoshizhongzanbuzhichiyujiansuo` | 检索式中出现 W/N，(S)，(P)，R，RAD，RPD 时，暂不支持预检索 |

> 官方手册 S1–S5 中 `R`/`RAD`/`RPD` 的章节标题为「**超级排序**」。另据官网首页（S9 同域），incoPat 另有独立的「语义检索 2.0」功能页 `home/yuyisearch`（「查看语义检索算法升级说明」）。

---

## 13. 公司树 `TREE@`

> 来源：**S1** §2.4.8「TREE@ 算符」原文。

1. 系统支持在指定字段中使用 **`TREE@` 算符**，搜索**一个机构名称以及其在 incoPat 工商树中的下级名称**的全部专利。其中，**`TREE@` 算符为精确匹配，所连接的名称必须为该机构名称的全名**。
2. **`TREE@` 算符的优先级高于逻辑运算符。**
3. **注意：仅支持 `ap-group` / `ap-grouptt` / `ap` / `aptt` 字段使用 `TREE@` 算符。**

**原文示例：**

```
（1）ap=( TREE@"清华大学")            （机构名称需用双引号""引用）
（2）aptt= ( TREE@"清华大学" AND TREE@"北京大学" )   （支持在同一字段中使用多个 TREE@ 算符）
（3）ap-group= ( "清华大学" AND TREE@ "北京大学" )   （支持在同一字段中对部分机构名称使用 TREE@ 算符）
```

**官方前端校验提示（S6），交叉验证字段白名单：**

| key | 中文文案 |
| --- | --- |
| `search_min_jinzhichiapapttapgroupapgrouptt` | **仅支持 AP/APTT/AP-GROUP/AP-GROUPTT** |
| `search_min_tongshijiansuogongshangshuzhongxiajimingcheng` | TREE@ 算符，同时检索其在 incoPat 工商树中的下级名称 |
| `search_min_shiyongTREEsuanfuyongshaungyinhaobaowei` | （机构名称）需用双引号包围 |

> 两处来源一致：**`TREE@` 仅可用于 `AP`、`APTT`、`AP-GROUP`、`AP-GROUPTT` 四个字段**，且机构名称必须用**双引号**包围。

---

## 14. 字段代码完整一览表

### 14.1 官方完整字段代码表的状态：**未获取到**

官方「**原始字段代码说明**」（`https://www.incopat.com/help/sysdoc/helpcode.html`）与「**同族字段代码说明**」（`helpcodeKin.html`）是唯一完整、权威且带**检索示例**的字段代码表，**现已迁入登录墙后**，公网无法访问（详见第 0 节）。

官方手册对该表的描述（**S1** §2.1.1 原文）：

> 「原始字段代码说明」中可以查看 incoPat 提供的全部字段说明及检索样例，包含**技术、公司&人、地域、分类、日期、法律、引证、同族**等类别。

官方手册给出的字段规模（**S4** §2.1.1 原文）：

> 「原始字段代码说明」中可以查看 incoPat 提供的全部 **266 个字段**说明。

官方旗舰版介绍（**S10**）给出的最新规模：

> 通过全面的数据整合加工，**可以检索的字段达到 330 多个**。

> 因此本文件中**没有**「每个字段的官方检索示例」—— 这部分原文**未获取到**，不做编造。

### 14.2 已确证可用的字段代码（有官方原文佐证）

> **⚠️ 使用前必读（2026-09-22 更正）**：本表的最初版本把「手册散文里提到的**字段类别**」
> 当成了「**字段代码原文**」，例如 `CL`（见下表，已证伪）。请**只采信「官方示例 / 佐证出处」
> 列里真正出现过该代码的行**；没有代码级示例的行（`AB`、原 `CL`）都只是推断，需另行核实。

下表列出在官方手册或官方前端资源中**明确出现过的字段代码**，可直接使用：

| 字段代码 | 中文含义 | 官方示例 / 佐证出处 |
| --- | --- | --- |
| `TI` | 标题 | `TI=("electronic vehicle")`（S1 §2.4.9）；`#1 and TI=computer`（S6/S7） |
| `TIAB` | 标题摘要 | `TIAB=(发动机)`（S1 §2.4.7 超级排序示例） |
| `AB` | 摘要 | ⚠️ **仅为推断**：手册只把摘要列为基本检索字段（S1 §2.1.1），未给出代码原文。`AB` 是真实字段，但本表给不出代码级佐证 |
| ~~`CL`~~ | ~~权利要求~~ | ❌ **已证伪（2026-09-22，维护者实测）**：官方字段说明页与数据库中**均无 `CL` 字段**，不能使用；权利要求对应的是 `CLAIM`。原表此行仅凭「手册把权利要求列为基本检索字段」这句散文**推断**出了代码 `CL`，属于编造 |
| `DES` | 说明书（描述） | `des=(粉碎效果(s)粉碎刀具(12w)轨迹)`、`des=(粉?效果(p)粉碎*具)`（S1 §2.4.5/§2.4.6 反例中使用） |
| `PD` | 公开（公告）日 | `(20110101<=pd<=20130101)`（S1 §2.4.4 范围运算符示例） |
| `AP` | 申请人 | `AP=(amazon.com)`（S1 §2.4.9）；`ap=( TREE@"清华大学")`（S1 §2.4.8） |
| `APTT` | 申请人（精确匹配） | `aptt=( TREE@"清华大学" AND TREE@"北京大学")`（S1 §2.4.8） |
| `AP-GROUP` | 申请人（多语种） | `ap-group=( "清华大学" AND TREE@"北京大学")`（S1 §2.4.8） |
| `AP-GROUPTT` | 申请人（多语种，精确匹配） | TREE@ 白名单（S1 §2.4.8；S6） |
| `IN` | 发明（设计）人 | `IN=(R 保罗)`、`IN=(R-保罗)`、`IN=("R 保罗")`（S1 §2.4.9） |
| `PN` | 公开（公告）号 | `应该为 PN 号或者关键词`（S6） |
| `R` | 超级排序（语义相似度排序） | `R=(CN101850473B) AND (TIAB=(发动机))`（S1 §2.4.7） |
| `RAD` | 按申请日限定的相似度排序 | `RAD=(CN1325248C) AND TI=(层压板)`（S1 §2.4.7） |
| `RPD` | 按公开日限定的相似度排序 | `RPD=(CN1325248C) AND TI=(层压板)`（S1 §2.4.7） |
| `TREE@` | 工商树（公司树）算符 | `ap=( TREE@"清华大学")`（S1 §2.4.8） |

### 14.3 官方系统中可检索字段清单（550 条，来自官方前端 i18n）

以下清单来自 **S6**（`https://www.incopat.com/resources/js/i18n/search.properties`，incoPat 官方服务器，2026-09-22 抓取）。它是 incoPat 前端「字段列表」中登记的**全部可检索字段标识**及其**官方中文名称**。

> **重要提示（务必注意）**：
> - 本表的「字段标识」是官方前端资源的 **key**。其中**一部分 key 就是检索式中的字段代码**（如 `APTT`、`INTT`、`TI_DWPI`、`ap_group`）；**另一部分 key 是拼音/英文内部标识**（如 `biaoti`、`zhaiyao`），其对应的**检索代码需查登录后的「原始字段代码说明」**，本次**未获取到**。
> - 因此本表可用于**了解 incoPat 支持哪些检索维度**，但**不能**直接把每一个 key 当作检索代码使用。
> - **官方检索示例：未获取到**（该列在官方文档中位于登录墙后）。

**字段标识与官方中文名称对照表（共 547 条，按官方资源中的登记顺序）：**

| # | 字段标识（官方前端 key） | 官方中文名称 |
| --- | --- | --- |
| 1 | `biaoti` | 标题 |
| 2 | `zhaiyao` | 摘要 |
| 3 | `quanliyaoqiu` | 权利要求 |
| 4 | `IPCfenlei` | IPC分类 |
| 5 | `luojianuofenlei` | 洛迦诺分类 |
| 6 | `shenqinghao` | 申请号 |
| 7 | `shenqingri` | 申请日 |
| 8 | `gongkaigonggaohao` | 公开(公告)号 |
| 9 | `gongkaigonggaori` | 公开(公告)日 |
| 10 | `shenqingren` | 申请人 |
| 11 | `shourangren` | 受让人 |
| 12 | `shenqingrendizhi` | 申请人地址 |
| 13 | `shenqingrenguobie` | 申请人国别 |
| 14 | `famingren` | 发明人 |
| 15 | `xukeren` | 许可人 |
| 16 | `beixukeren` | 被许可人 |
| 17 | `faluzhuangtaiwenzixinxi` | 法律状态文字信息 |
| 18 | `fushenwuxiaoquanwen` | 复审无效全文 |
| 19 | `zhuanliyouxiaoxing` | 专利有效性 |
| 20 | `susongdangshiren` | 诉讼当事人 |
| 21 | `biaotiO` | 标题(O) |
| 22 | `biaotixiaoyuzhong` | 标题小语种 |
| 23 | `biaotifanyi` | 标题翻译 |
| 24 | `zhaiyaoO` | 摘要(O) |
| 25 | `zhaiyaoxiaoyuzhong` | 摘要小语种 |
| 26 | `zhaiyaofanyi` | 摘要翻译 |
| 27 | `tuxingmiaoshu` | 图形描述 |
| 28 | `yitusoutu` | 以图搜图 |
| 29 | `yiwensoutu` | 以文搜图 |
| 30 | `ainknowtextsearchpicture` | 提示语\tAI理解文字语义，检索相关图片 |
| 31 | `nolimitsearchtext` | 未限制著录项条件 |
| 32 | `yiwensoututextareatip` | 请用中文或英文描述需检索图片的关键特征，如物品名称、形状、图案、色彩等 |
| 33 | `yiwensoututextareatipexample` | 例：高领灰色毛衣，长袖设计，正面带有绿色波点装饰 |
| 34 | `chorenmiaoshumaintezheng` | 请用中文或英文描述图片的关键特征 |
| 35 | `biaotizhaiyao` | 标题摘要 |
| 36 | `quanliyaoqiushuliang` | 权利要求数量 |
| 37 | `biaotizhaiyaoquanliyaoqiu` | 标题摘要权利要求 |
| 38 | `shuomingshu` | 说明书 |
| 39 | `gongsimingherenming` | 公司名和人名 |
| 40 | `zhuyaozhuluxinxi` | 主要著录信息 |
| 41 | `quanwen` | 全文 |
| 42 | `shenqingyuyan` | 申请语言 |
| 43 | `zhuanlishouming` | 专利寿命 |
| 44 | `shenchashizhang` | 审查时长 |
| 45 | `tichushishenshizhang` | 进入实质审查时长 |
| 46 | `shuomingshuyuanshiyuyan` | 说明书原始语言 |
| 47 | `youxianquanxinxi` | 优先权信息 |
| 48 | `wenxianyeshu` | 文献页数 |
| 49 | `zhuanlijiazhidu` | 合享价值度 |
| 50 | `jianglidengji` | 奖励等级 |
| 51 | `jianglimingcheng` | 奖励名称 |
| 52 | `jianglijieci` | 奖励届次 |
| 53 | `shenqingrenyuanshi` | 申请人(原始) |
| 54 | `shenqingrenqita` | 申请人(其他) |
| 55 | `shenqingrenfanyi` | 申请人(翻译) |
| 56 | `biaozhunshenqingren` | 标准申请人 |
| 57 | `zhuanrangren` | 转让人 |
| 58 | `zhuanranghuoshourangren` | 转让或受让人 |
| 59 | `biaozhunshourangren` | 标准受让人 |
| 60 | `qitayuyanshenqingrendizhi` | 其他语言申请人地址 |
| 61 | `dailirenxingming` | 代理人姓名 |
| 62 | `dailijigou` | 代理机构 |
| 63 | `fushenqingqiuren` | 复审请求人 |
| 64 | `wuxiaoqingqiuren` | 无效请求人 |
| 65 | `fushenwuxiaozhushenyuan` | 复审无效主审员 |
| 66 | `fushenwuxiaocanshenyuan` | 复审无效参审员 |
| 67 | `fushenwuxiaoheyizuzuzhang` | 复审无效合议组组长 |
| 68 | `chuzhiren` | 出质人 |
| 69 | `zhiquanren` | 质权人 |
| 70 | `shenchayuan` | 审查员 |
| 71 | `shenqingrenleixing` | 申请人类型 |
| 72 | `IPCzhufenlei` | IPC主分类 |
| 73 | `IPCfenlei_bu` | IPC分类-部 |
| 74 | `IPCfenlei_dalei` | IPC分类-大类 |
| 75 | `IPCfenlei_xiaolei` | IPC分类-小类 |
| 76 | `IPCfenlei_dazu` | IPC分类-大组 |
| 77 | `IPCzhufenlei_bu` | IPC主分类-部 |
| 78 | `IPCzhufenlei_dalei` | IPC主分类-大类 |
| 79 | `IPCzhufenlei_xiaolei` | IPC主分类-小类 |
| 80 | `IPCzhufenlei_dazu` | IPC主分类-大组 |
| 81 | `IPCfenlei_xiaozu` | IPC分类-小组 |
| 82 | `ouzhouECfenlei` | 欧洲EC分类 |
| 83 | `ouzhouECfenlei_bu` | 欧洲EC分类-部 |
| 84 | `ouzhouECfenlei_dalei` | 欧洲EC分类-大类 |
| 85 | `ouzhouECfenlei_xiaolei` | 欧洲EC分类-小类 |
| 86 | `ouzhouECfenlei_dazu` | 欧洲EC分类-大组 |
| 87 | `ouzhouECfenlei_xiaozu` | 欧洲EC分类-小组 |
| 88 | `meiguoUCfenlei` | 美国UC分类 |
| 89 | `meiguozhuUCfenlei` | 美国主UC分类 |
| 90 | `CPCfenlei` | CPC分类 |
| 91 | `CPCfenlei_bu` | CPC分类-部 |
| 92 | `CPCfenlei_dalei` | CPC分类-大类 |
| 93 | `CPCfenlei_xiaolei` | CPC分类-小类 |
| 94 | `CPCfenlei_dazu` | CPC分类-大组 |
| 95 | `CPCfenlei_xiaozu` | CPC分类-小组 |
| 96 | `ribenfifenlei` | 日本fi分类 |
| 97 | `ribenftermfenlei` | 日本fterm分类 |
| 98 | `fenleihao` | 分类号 |
| 99 | `zhongguofanchoufenlei` | 中国范畴分类 |
| 100 | `xingyemenlei` | 国民经济行业门类 |
| 101 | `xingyedalei` | 国民经济行业大类 |
| 102 | `xingyezhonglei` | 国民经济行业中类 |
| 103 | `xingyexiaolei` | 国民经济行业小类 |
| 104 | `cpczhufenleihao` | CPC主分类号 |
| 105 | `cpczhufenleibu` | CPC主分类-部 |
| 106 | `cpczhufenleidalei` | CPC主分类-大类 |
| 107 | `cpczhufenleixiaolei` | CPC主分类-小类 |
| 108 | `cpczhufenleidazu` | CPC主分类-大组 |
| 109 | `cpczhufenleixiaozu` | CPC主分类-小组 |
| 110 | `famingrenguobie` | 发明人国别 |
| 111 | `zhuanlishenqingdeguobie` | 专利申请的国别 |
| 112 | `gongkaiguobie` | 公开国别 |
| 113 | `youxianquanguobie` | 优先权国别 |
| 114 | `shenqingrenshengshi` | 申请人省市 |
| 115 | `zhongguoshengshidaima` | 中国省市代码 |
| 116 | `zhongguoshenqingrenshengshidaima` | 中国申请人省市代码 |
| 117 | `zhongguoshenqingrendishi` | 中国申请人地市 |
| 118 | `zhongguoshenqingrenquxian` | 中国申请人区县 |
| 119 | `famingrendizhi` | 发明人地址 |
| 120 | `famingrenchengshi` | 发明人城市 |
| 121 | `famingrensuozaizhou` | 发明人所在州 |
| 122 | `shourangrenguobie` | 受让人国别 |
| 123 | `shourangrendizhi` | 受让人地址 |
| 124 | `dangqianshourangrendizhi` | 当前受让人地址 |
| 125 | `shourangrenzhou` | 受让人州 |
| 126 | `shourangrenchengshi` | 受让人城市 |
| 127 | `dailirenguobie` | 代理人国别 |
| 128 | `dailirendizhi` | 代理人地址 |
| 129 | `dailirenchengshi` | 代理人城市 |
| 130 | `dailirensuozaizhou` | 代理人所在州 |
| 131 | `caijuepanjuefashengdi` | 裁决判决发生地 |
| 132 | `shenqinghaohaoma` | 申请号号码 |
| 133 | `gongkaihaohaoma` | 公开号号码 |
| 134 | `youxianquanhao` | 优先权号 |
| 135 | `youxianquanhaohaoma` | 优先权号号码 |
| 136 | `gongkaileixing` | 公开类型 |
| 137 | `zhuanliwenxianzhongleibiaoshidaima` | 专利文献种类标识代码 |
| 138 | `jiandantongzu` | 简单同族 |
| 139 | `kuozhantongzu` | 扩展同族 |
| 140 | `jiandantongzugeshu` | 简单同族个数 |
| 141 | `kuozhantongzugeshu` | 扩展同族个数 |
| 142 | `INPADOCtongzu` | DocDB同族 |
| 143 | `jiandantongzu_c` | 简单同族 |
| 144 | `kuozhantongzu_c` | 扩展同族 |
| 145 | `INPADOCtongzu_c` | DocDB同族 |
| 146 | `INPADOCtongzugeshu` | DocDB同族个数 |
| 147 | `tongzuguojia` | 同族国家/地区 |
| 148 | `haoma` | 号码 |
| 149 | `fushenwuxiaojuedinghao` | 复审无效决定号 |
| 150 | `fushenwuxiaoweineibianhao` | 复审无效委内编号 |
| 151 | `xukehetongbeianhao` | 许可合同备案号 |
| 152 | `zhiyahao` | 质押号 |
| 153 | `PCTguojishenqinggongkaihao` | PCT国际申请公开号 |
| 154 | `shenqingyue` | 申请月 |
| 155 | `shenqingnian` | 申请年 |
| 156 | `shoucigongkairi` | 首次公开日 |
| 157 | `gongkainian` | 公开年 |
| 158 | `gongkaiyue` | 公开月 |
| 159 | `youxianquanri` | 优先权日 |
| 160 | `youxianquannian` | 优先权年 |
| 161 | `yinzhengshenqingri` | 引证申请日 |
| 162 | `yinzhenggongkairi` | 引证公开日 |
| 163 | `beiyinzhengshenqingri` | 被引证申请日 |
| 164 | `beiyinzhenggongkairi` | 被引证公开日 |
| 165 | `beiyinzhengshenqingnian` | 被引证申请年 |
| 166 | `shizhishenchashengxiaori` | 实质审查生效日 |
| 167 | `shouquangonggaori` | 授权公告日 |
| 168 | `shixiaori` | 失效日 |
| 169 | `PCTjinruguojiajieduanri` | PCT进入国家阶段日 |
| 170 | `fushenwuxiaojuedingnian` | 复审无效决定年 |
| 171 | `zhiyajiechunian` | 质押年 |
| 172 | `zhuanrangnian` | 转让年 |
| 173 | `xukenian` | 许可年 |
| 174 | `wendangzhengtigengxinshijian` | 文档整体更新时间 |
| 175 | `yinzhengzhengtigengxinshijian` | 引证整体更新时间 |
| 176 | `zhuanliyinzhenggengxinshijian` | 专利引证更新时间 |
| 177 | `feizhuanliyinzhenggengxinshijian` | 非专利引证更新时间 |
| 178 | `zhuanlibeiyinzhenggengxinshijian` | 专利被引证更新时间 |
| 179 | `tongzuxinxigengxinshijian` | 同族信息更新时间 |
| 180 | `zhuanrangzhixingri` | 转让执行日 |
| 181 | `fushenwuxiaojuedingri` | 复审无效决定日 |
| 182 | `faluwenshuriqi` | 法律文书日期 |
| 183 | `faluzhuangtaigonggaoshijian` | 法律状态公告时间 |
| 184 | `zhiyashengxiaori` | 质押生效日 |
| 185 | `zhiyaqixian` | 质押期限 |
| 186 | `xukehetongbeianriqi` | 许可合同备案日期 |
| 187 | `xukehetongluxingqishiri` | 许可合同履行起始日 |
| 188 | `xukehetongluxingzhongzhiri` | 许可合同履行终止日 |
| 189 | `zhiyabiangengri` | 质押变更日 |
| 190 | `zhiyajiechuri` | 质押解除日 |
| 191 | `susongnian` | 诉讼年 |
| 192 | `dangqianfaluzhuangtai` | 当前法律状态 |
| 193 | `faluzhuangtaizhongdefalushijian` | 法律状态中的法律事件 |
| 194 | `faluzhuangtaixiaoguo` | 法律状态效果 |
| 195 | `faluzhuangtaidaima` | 法律状态代码 |
| 196 | `fushenwuxiaoleixing` | 复审无效类型 |
| 197 | `fushenwuxiaoqingqiuren` | 复审/无效请求人 |
| 198 | `fushenwuxiaofaluyiju` | 复审无效法律依据 |
| 199 | `fushenwuxiaojuedingyaodian` | 复审无效决定要点 |
| 200 | `fating` | 法庭 |
| 201 | `faguan` | 法官 |
| 202 | `susonglushishiwusuo` | 诉讼律师事务所 |
| 203 | `susonganjianhao` | 诉讼案件号 |
| 204 | `zhuanlizhuanyiyuanyin` | 专利转移原因 |
| 205 | `faluwenshutimu` | 法律文书题目 |
| 206 | `faluwenshujutineirong` | 法律文书具体内容 |
| 207 | `faluwenshuzhonglei` | 法律文书种类 |
| 208 | `faluwenshubianhao` | 法律文书编号 |
| 209 | `yuangao` | 原告 |
| 210 | `beigao` | 被告 |
| 211 | `xukeleixing` | 许可类型 |
| 212 | `xukebeianjieduan` | 许可备案阶段 |
| 213 | `dangqianxukebeianjieduan` | 当前许可备案阶段 |
| 214 | `dangqianbeixukeren` | 当前被许可人 |
| 215 | `dangqianzhuanliquanren` | 当前权利人 |
| 216 | `biaozhunhuadangqianzhuanliquanren` | 标准化当前权利人 |
| 217 | `dangqianzhiquanren` | 当前质权人 |
| 218 | `zhiyabaoquanleixing` | 质押保全类型 |
| 219 | `hetongbeianjieduan` | 质押/保全合同备案阶段 |
| 220 | `faluzhuangtaiquanwen` | 法律状态全文 |
| 221 | `zhuanrangbiaoqian` | 转让标签 |
| 222 | `xukebiaoqian` | 许可标签 |
| 223 | `zhiyabiaoqian` | 质押/保全标签 |
| 224 | `fushenwuxiaoshenchajuedingbiaoqian` | 复审无效审查决定标签 |
| 225 | `susongbiaoqian` | 诉讼标签 |
| 226 | `haiguanzhuanlibiaoqian` | 海关专利标签 |
| 227 | `yinzhengxinxibackward` | 引证信息(backward) |
| 228 | `beiyinzhengxinxiforward` | 被引证信息(forward) |
| 229 | `yinzhengcishubackward` | 引证次数(backward) |
| 230 | `beiyinzhengcishuforward` | 被引证次数 (forward) |
| 231 | `jiazuyinzhengbackward` | 家族引证(backward) |
| 232 | `jiazubeiyinzhengforward` | 家族被引证(forward) |
| 233 | `yinzhengshenqingrenbackward` | 引证申请人(backward) |
| 234 | `beiyinzhengshenqingrenforward` | 被引证申请人(forward) |
| 235 | `jiazuyinzhengshenqingrenbackward` | 家族引证申请人(backward) |
| 236 | `jiazubeiyinzhengshenqingrenforward` | 家族被引证申请人(forward) |
| 237 | `yinzhenghaomabackward` | 引证号码(backward) |
| 238 | `beiyinzhenghaomaforward` | 被引证号码(forward) |
| 239 | `yinzhengguobiebackward` | 引证国别(backward) |
| 240 | `beiyinzhengguobieforward` | 被引证国别(forward) |
| 241 | `yinzhengleibiebackward` | 引证类别(backward) |
| 242 | `jiazuyinzhengcishubackward` | 家族引证次数(backward) |
| 243 | `jiazubeiyinzhengcishuforward` | 家族被引证次数(forward) |
| 244 | `feizhuanliyinzheng` | 非专利引证 |
| 245 | `PCTguojishenqingshenqinghao` | PCT国际申请申请号 |
| 246 | `shuomingshuzhongwenfanyi` | 说明书-其他语言 |
| 247 | `shuomingshuyingwenfanyi` | 说明书英文翻译 |
| 248 | `jishulingyu` | 技术领域 |
| 249 | `beijingjishu` | 背景技术 |
| 250 | `famingneirong` | 发明内容 |
| 251 | `jutishishifangshi` | 具体实施方式 |
| 252 | `quanliyaoqiu_yingwen` | 权利要求-英文 |
| 253 | `quanliyaoqiu_fanyi` | 权利要求-其他语言 |
| 254 | `quanliyaoqiu_yuanwen` | 权利要求-中文 |
| 255 | `ETSIbiaozhun` | ETSI标准 |
| 256 | `biaozhunhao` | 标准号 |
| 257 | `gongsibiaozhun` | 公司(标准) |
| 258 | `biaozhunzhuanlibiaoqian` | 标准专利标签 |
| 259 | `apfirst` | 第一申请人 |
| 260 | `allbiaoqian` | all标签 |
| 261 | `zhuanrangcishu` | 转让次数 |
| 262 | `anyou` | 案由 |
| 263 | `lvsuo` | 律所 |
| 264 | `lvshi` | 律师 |
| 265 | `susongcishu` | 诉讼次数 |
| 266 | `xukecishu` | 许可次数 |
| 267 | `shenlichengxu` | 审理程序 |
| 268 | `falvzhuangtaiyouweishouquanhuoshixiaobianweiyouxiao` | 法律状态由未授权或失效变为有效 |
| 269 | `falvzhuangtaiyouweishouquanbianweiyishixiao` | 法律状态由未授权变为已失效 |
| 270 | `falvzhuangtaiyouyouxiaobianweiyishixiao` | 法律状态由有效变为已失效 |
| 271 | `panpeijine` | 判赔金额 |
| 272 | `fushenjueding` | 复审无效决定 |
| 273 | `fushenwuxiaoqingqiuri` | 复审无效请求日 |
| 274 | `diyifamingren` | 第一发明人 |
| 275 | `famingren_yuanshi` | 发明人(原始) |
| 276 | `famingren_xiaoyuzhong` | 发明人(其他) |
| 277 | `famingren_fanyi` | 发明人(翻译) |
| 278 | `shenqingrenshuliang` | 申请人数量 |
| 279 | `famingrenshuliang` | 发明人数量 |
| 280 | `Xyinzhengzhuanli` | X引证专利 |
| 281 | `beiyinzhengleibie` | 被引证类别 |
| 282 | `Xbeiyinzhuanli` | X被引专利 |
| 283 | `haiguanbeianzuijingengxinshijian` | 海关备案最近更新时间 |
| 284 | `shixiaozuijingengxinshijian` | 失效最近更新时间 |
| 285 | `tongzubeiyinzhengzuijingengxinshijian` | 同族被引证最近更新时间 |
| 286 | `shouquanzuijingengxinshijian` | 授权最近更新时间 |
| 287 | `biaozhunzhuanlizuijingengxinshijian` | 标准专利最近更新时间 |
| 288 | `luojianuofenleidalei` | 洛迦诺分类大类 |
| 289 | `luojianuofenleixiaolei` | 洛迦诺分类小类 |
| 290 | `jishuwendingxing` | 技术稳定性 |
| 291 | `jishuxianjinxing` | 技术先进性 |
| 292 | `baohufanwei` | 保护范围 |
| 293 | `zuizaoyouxianquanri` | 最早优先权日 |
| 294 | `shouxiangquanliyaoqiu` | 首项权利要求 |
| 295 | `dizhi` | 地址 |
| 296 | `zhiyacishu` | 质押/保全次数 |
| 297 | `yinzhenggongkainian` | 引证公开年 |
| 298 | `famingrendizhiyingwen` | 发明人地址(英文) |
| 299 | `shengqingrendizhiyingwen` | 申请人地址(英文) |
| 300 | `shengqingrendizhiyuanshi` | 申请人地址(原始) |
| 301 | `WOSxuekefenleihaoyijixueke` | WOS学科分类号-一级学科 |
| 302 | `WOSxuekefenleihaoxuekefangxian` | WOS学科分类号-学科方向 |
| 303 | `WOSxuekefenleihaoWOSxueke` | WOS学科分类号-WOS学科 |
| 304 | `WOSxuekefenleihaoxuekefenlei` | WOS学科分类号-学科分类 |
| 305 | `IPCzhufenleisuoyoushangweidianzu` | IPC主分类所有上位点组 |
| 306 | `IPCzhufenleisuoyouxiaweidianzu` | IPC主分类所有下位点组 |
| 307 | `IPCsuoyoushangweidianzu` | IPC所有上位点组 |
| 308 | `IPCsuoyouxiaweidianzu` | IPC所有下位点组 |
| 309 | `action_types` | 诉讼类型 |
| 310 | `ori_prdate` | 最早优先权日 |
| 311 | `expiry_year` | 失效年 |
| 312 | `change_dc` | 变更入库时间 |
| 313 | `san` | 母案 |
| 314 | `subsan` | 分案 |
| 315 | `ap_new_name` | 专利权人（申请人）变更后名称 |
| 316 | `afirst_claim_cn` | 首项权利要求-中文 |
| 317 | `first_claim_en` | 首项权利要求-英文 |
| 318 | `len_first_claim` | 首权字数 |
| 319 | `ap_as` | 工商别名 |
| 320 | `ap_en` | 工商英文名 |
| 321 | `ap_reg_locationn` | 工商注册地址 |
| 322 | `ap_company_org_type` | 工商公司类型 |
| 323 | `ap_estiblish_time` | 工商成立日期 |
| 324 | `ap_usc` | 工商统一社会信用代码 |
| 325 | `ap_reg_number` | 工商注册号 |
| 326 | `ap_reg_status` | 工商企业状态 |
| 327 | `ap_list_code` | 工商上市代码 |
| 328 | `cas_no` | FDA-CAS号 |
| 329 | `drug_name_cn` | FDA-中文名称 |
| 330 | `drug_name_en` | FDA-英文名称 |
| 331 | `company` | FDA-公司名称 |
| 332 | `brand_name` | FDA-商品名 |
| 333 | `active_ingredient` | FDA-活性成分 |
| 334 | `target` | FDA-靶点 |
| 335 | `indication` | FDA-适应症 |
| 336 | `patent_expiration` | FDA-专利到期日 |
| 337 | `PED_patent_expiration` | FDA-PED药物专利到期日 |
| 338 | `IN_ADD_OTH` | 发明人地址（其他） |
| 339 | `IN_OR_ADD` | 发明人地址（原始） |
| 340 | `des_cn` | 说明书中文翻译 |
| 341 | `APTT` | 申请人(精确匹配) |
| 342 | `INTT` | 发明(设计)人(精确匹配) |
| 343 | `APNOR` | 标准申请人 |
| 344 | `EFFECT_S_CN` | 技术功效句 |
| 345 | `EFFECT_PH_CN` | 技术功效短语 |
| 346 | `EFFECT_CN` | 技术功效 |
| 347 | `EFFECT_CN_3` | 技术功效3级 |
| 348 | `EFFECT_CN_2` | 技术功效2级 |
| 349 | `EFFECT_CN_1` | 技术功效1级 |
| 350 | `EFFECT_TRIZ` | 技术功效TRIZ参数 |
| 351 | `EFFECT_PH_CNTT` | 技术功效短语 |
| 352 | `RE_DATE` | 复审决定日 |
| 353 | `IN_DATE` | 无效决定日 |
| 354 | `OR_DATE` | 口审日期 |
| 355 | `REAPP_DATE` | 复审请求日 |
| 356 | `INAPP_DATE` | 无效请求日 |
| 357 | `ORI_PRYEAR` | 最早优先权年 |
| 358 | `yianshuangshen` | 一案双申 |
| 359 | `yiyifang` | 异议方 |
| 360 | `TIAB_DWPI` | 标题摘要(含DWPI) |
| 361 | `TI_DWPI` | DWPI标题 |
| 362 | `USE_DWPI` | DWPI用途 |
| 363 | `ADV_DWPI` | DWPI优势 |
| 364 | `NOVELTY_DWPI` | DWPI新颖性 |
| 365 | `ABSTRACT_DWPI` | DWPI摘要 |
| 366 | `F_DWPI` | DWPI同族 |
| 367 | `FN_DWPI` | DWPI同族个数 |
| 368 | `industry1` | 新兴产业门类 |
| 369 | `industry2` | 新兴产业大类 |
| 370 | `dangqianfamingrenmingcheng` | 当前发明人名称 |
| 371 | `famingrenbiangenghoumingcheng` | 发明人变更后名称 |
| 372 | `duliquanliyaoqiu` | 独立权利要求 |
| 373 | `congshuquanliyaoqiu` | 从属权利要求 |
| 374 | `duliquanliyaoqiushuliang` | 独立权利要求数量 |
| 375 | `congshuquanliyaoqiushuliang` | 从属权利要求数量 |
| 376 | `lianriqi` | 立案日期 |
| 377 | `jieanriqi` | 结案日期 |
| 378 | `liannian` | 立案年 |
| 379 | `jieannian` | 结案年 |
| 380 | `zhuanrangdengjihao` | 转让登记号 |
| 381 | `zhuanrangdengjiri` | 转让登记日 |
| 382 | `biaoti_zhongwen` | 标题-中文 |
| 383 | `biaoti_yingwen` | 标题-英文 |
| 384 | `zhaiyao_zhongwen` | 摘要-中文 |
| 385 | `zhaiyao_yingwen` | 摘要-英文 |
| 386 | `yugudaoqiri` | 预估到期日 |
| 387 | `shouquangonggaohao` | 授权公告号 |
| 388 | `shoucigongkaihao` | 首次公开号 |
| 389 | `zhuanrangrenleixing` | 转让人类型 |
| 390 | `shourangrenleixing` | 受让人类型 |
| 391 | `xukerenleixing` | 许可人类型 |
| 392 | `beixukerenleixing` | 被许可人类型 |
| 393 | `suoyoushenqingren` | 申请人(全) |
| 394 | `zhongguodangqianzhuanliquanrendizhi` | 当前专利权人地址 |
| 395 | `zhongguodangqianzhuanliquanrenshengshi` | 当前专利权人省市 |
| 396 | `zhongguodangqianzhuanliquanrendishi` | 当前专利权人地市 |
| 397 | `zhongguodangqianzhuanliquanrenquxian` | 当前专利权人区县 |
| 398 | `zhongguoshourangrenshengshi` | 受让人省市 |
| 399 | `zhongguoshourangrendishi` | 受让人地市 |
| 400 | `zhongguoshourangrenquxian` | 受让人区县 |
| 401 | `zhongguozhuanrangrenshengshi` | 转让人省市 |
| 402 | `zhongguozhuanrangrendishi` | 转让人地市 |
| 403 | `zhongguozhuanrangrenquxian` | 转让人区县 |
| 404 | `zhuanlileixing` | 专利类型 |
| 405 | `PR_DATE_DWPI` | DWPI优先权日 |
| 406 | `CK_DWPI` | DWPI专利权人代码 |
| 407 | `CO_DWPI` | DWPI专利权人/申请人 |
| 408 | `IN_DWPI` | DWPI发明人 |
| 409 | `MC_DWPI` | DWPI手工代码 |
| 410 | `DC_DWPI` | DWPI分类号 |
| 411 | `DC_SECTION_DWPI` | DWPI分类号-部 |
| 412 | `DC_CLASS_DWPI` | DWPI分类号-大类 |
| 413 | `IPC_DWPI` | DWPI现版IPC分类号 |
| 414 | `IPC_SECTION_DWPI` | DWPI现版IPC分类号-部 |
| 415 | `IPC_CLASS_DWPI` | DWPI现版IPC分类号-大类 |
| 416 | `IPC_SUBCLASS_DWPI` | DWPI现版IPC分类号-小类 |
| 417 | `IPC_GROUP_DWPI` | DWPI现版IPC分类号-大组 |
| 418 | `IPC_SUBGROUP_DWPI` | DWPI现版IPC分类号-小组 |
| 419 | `IPC_F_DWPI` | DWPI同族的IPC分类号 |
| 420 | `IPC_SECTION_F_DWPI` | DWPI同族的IPC分类号-部 |
| 421 | `IPC_CLASS_F_DWPI` | DWPI同族的IPC分类号-大类 |
| 422 | `IPC_SUBCLASS_F_DWPI` | DWPI同族的IPC分类号-小类 |
| 423 | `IPC_GROUP_F_DWPI` | DWPI同族的IPC分类号-大组 |
| 424 | `IPC_SUBGROUP_F_DWPI` | DWPI同族的IPC分类号-小组 |
| 425 | `PRD_DWPI` | DWPI优先权信息 |
| 426 | `CK_TYPE_DWPI` | 专利权人类型 - DWPI |
| 427 | `ABX_DWPI` | 摘要 - 扩展 - DWPI |
| 428 | `ADM_DWPI` | 摘要 - 扩展 - 给药 - DWPI |
| 429 | `DEF_DWPI` | 摘要 - 扩展 - 定义 - DWPI |
| 430 | `EXA_DWPI` | 摘要 - 扩展 - 示例 - DWPI |
| 431 | `ART_DWPI` | 摘要 - 扩展 - 在先技术 - DWPI |
| 432 | `SCM_DWPI` | 摘要 - 扩展 - 特定化合物 - DWPI |
| 433 | `WDC_DWPI` | 摘要 - 扩展 - 更广泛的公开 - DWPI |
| 434 | `MCC_DWPI` | DWPI手工代码 - 化学 (MCC) |
| 435 | `MCE_DWPI` | DWPI手工代码 - 电子 |
| 436 | `MCM_DWPI` | DWPI手工代码 - 机械 |
| 437 | `PLC_DWPI` | DWPI聚合物代码 (PLC) |
| 438 | `MPLC_DWPI` | DWPI聚合物打孔码 |
| 439 | `KPLC_DWPI` | DWPI聚合物关键序列码 |
| 440 | `PLI_DWPI` | DWPI聚合物索引 (PLI) |
| 441 | `CRN_DWPI` | DWPI化学资源号 |
| 442 | `RN_DWPI` | DWPI注册号 |
| 443 | `CN_DWPI` | DWPI化合物号 |
| 444 | `MCN_DWPI` | DWPI Markush化合物号 |
| 445 | `RIN_DWPI` | DWPI环系索引号 |
| 446 | `CLCDCR_DWPI` | DWPI化学结构片段代码 |
| 447 | `CCS_DWPI` | DWPI化学子标题 |
| 448 | `CLC_DWPI` | DWPI化学链接代码 (CLC) |
| 449 | `FA_COUNTRY_DWPI` | DWPI同族国家/地区 |
| 450 | `FCN_DWPI` | DWPI同族国家个数 |
| 451 | `DTD_DWPI` | DWPI详细描述 |
| 452 | `ACTIVITY_DWPI` | DWPI生物活性 |
| 453 | `MEC_DWPI` | DWPI生物学机制 |
| 454 | `FOC_DWPI` | DWPI技术要点 |
| 455 | `TIT_DWPI` | DWPI标题词 |
| 456 | `DRAW_DWPI` | DWPI附图说明 |
| 457 | `ORIPRC_DWPI` | DWPI优先权国别-最早 |
| 458 | `ORI_PRYEAR_DWPI` | DWPI优先权年-最早 |
| 459 | `PR_DWPI` | DWPI优先权号 |
| 460 | `PR_AU_DWPI` | DWPI优先权国别 |
| 461 | `RADD_DWPI` | DWPI相关专利申请日期 |
| 462 | `RAND_DWPI` | DWPI相关专利申请号 |
| 463 | `RPND_DWPI` | DWPI相关公开号 |
| 464 | `STATUS_DWPI` | DWPI专利状态 |
| 465 | `ziyinxinxi` | 自引信息 |
| 466 | `tayinxinxi` | 他引信息 |
| 467 | `beiziyinxinxi` | 被自引信息 |
| 468 | `beitayinxinxi` | 被他引信息 |
| 469 | `ziyincishu` | 自引次数 |
| 470 | `tayincishu` | 他引次数 |
| 471 | `beiziyincishu` | 被自引次数 |
| 472 | `beitayincishu` | 被他引次数 |
| 473 | `yinzhenglaiyuan` | 引证来源 |
| 474 | `beiyinzhenglaiyuan` | 被引证来源 |
| 475 | `ap_group` | 申请人(多语种） |
| 476 | `ap_grouptt` | 申请人(多语种）(精确匹配) |
| 477 | `indepclaims_en` | 独立权利要求(英文) |
| 478 | `depclaims_en` | 从属权利要求(英文) |
| 479 | `indepclaim` | 独立权利要求 |
| 480 | `depclaim` | 从属权利要求 |
| 481 | `mbclass` | 国民经济行业(主) |
| 482 | `mbclas1` | 主国民经济行业门类 |
| 483 | `mbclas2` | 主国民经济行业大类 |
| 484 | `mbclas3` | 主国民经济行业中类 |
| 485 | `mbclas4` | 主国民经济行业小类 |
| 486 | `mindustry1` | 主新兴产业门类 |
| 487 | `mindustry2` | 主新兴产业大类 |
| 488 | `bclass` | 国民经济行业分类 |
| 489 | `mindustry` | 新兴产业(主) |
| 490 | `shourangrenjingquepipei` | 受让人(精确匹配) |
| 491 | `dangqianquanlirenjingquepipei` | 当前权利人(精确匹配) |
| 492 | `sc_main` | 一级学科 |
| 493 | `sc_section` | 学科方向 |
| 494 | `sc_class` | WOS学科 |
| 495 | `sc_subclass` | 学科分类 |
| 496 | `wos` | 学科分类 |
| 497 | `suoxie_sc_main` | 一级学科 |
| 498 | `suoxie_sc_section` | 学科方向 |
| 499 | `suoxie_sc_class` | WOS学科 |
| 500 | `suoxie_sc_subclass` | 学科分类 |
| 501 | `MC_SECTION_DWPI` | DWPI手工代码-部 |
| 502 | `MC_CLASS_DWPI` | DWPI手工代码-大类 |
| 503 | `MC_GROUP_DWPI` | DWPI手工代码-组 |
| 504 | `MC_SUBGROUP_DWPI` | DWPI手工代码-小组 |
| 505 | `MC_SUBGROUPD_DWPI` | DWPI手工代码-小组分支 |
| 506 | `MC_FULLMC_DWPI` | DWPI手工代码-级 |
| 507 | `MC_FULLMCX_DWPI` | DWPI手工代码-次级 |
| 508 | `assignor_add` | 转让人地址 |
| 509 | `industry_type` | 行业分类 |
| 510 | `mkclas1` | 知识密集大类 |
| 511 | `mkclas2` | 知识密集中类 |
| 512 | `lngclas1` | 清洁能源产业大类 |
| 513 | `lngclas2` | 清洁能源产业中类 |
| 514 | `lngclas3` | 清洁能源产业小类 |
| 515 | `cpclas1` | 清洁生产产业大类 |
| 516 | `cpclas2` | 清洁生产产业中类 |
| 517 | `cpclas3` | 清洁生产产业小类 |
| 518 | `digclas1` | 数字经济核心产业大类 |
| 519 | `digclas2` | 数字经济核心产业中类 |
| 520 | `digclas3` | 数字经济核心产业小类 |
| 521 | `zhishimijixingfeilei` | 知识密集型分类 |
| 522 | `qingjienengyuanchanye` | 清洁能源产业分类 |
| 523 | `qingjieshengchanchanye` | 清洁生产产业分类 |
| 524 | `shuzijingjihexinchanye` | 数字经济核心产业分类 |
| 525 | `xuekefenlei` | 学科分类 |
| 526 | `yanxumuan` | 延续母案 |
| 527 | `bufenyanxumuan` | 部分延续母案 |
| 528 | `yongtu_cn` | 用途-中文 |
| 529 | `yongtu_en` | 用途-英文 |
| 530 | `USETT_CN` | 用途 |
| 531 | `assign_type` | 转让类型 |
| 532 | `pinglun` | 评论 |
| 533 | `de_country` | EP指定生效国 |
| 534 | `ap_lite` | 申请人(基础) |
| 535 | `patentee_type` | 当前权利人类型 |
| 536 | `ap_root` | 申请人终属母公司 |
| 537 | `flag_337` | 337标记 |
| 538 | `IPC_LOW` | IPC所有下位点组 |
| 539 | `IPCM_LOW` | IPC主分类所有下位点组 |
| 540 | `pu_year` | 首次公开年 |
| 541 | `pu_month` | 首次公开月 |
| 542 | `grant_year` | 授权公告年 |
| 543 | `grant_month` | 授权公告月 |
| 544 | `exdt_year` | 预估到期年 |
| 545 | `exdt_month` | 预估到期月 |
| 546 | `prd_flag` | 优先权标签 |
| 547 | `no_image` | 附图个数 |

---

## 15. 新增 / 变更点总结（重点）

以下为本次通过**跨版本比对**（S4 = 2019-05 → S3 = 2020-12 → S2 = 2024 Q4 → S1 = 2026 Q1）以及**官方前端校验资源**（S6，反映**当前线上版本**的真实行为）发现的差异与新增点。

### 15.1 相对旧版官方手册的**新增**内容

| # | 变更点 | 旧版情况 | 新版情况 | 出处 |
| --- | --- | --- | --- | --- |
| **1** | **新增 `TREE@` 算符（公司树检索）** | S3（2020-12）§2.4 中**没有** TREE@ 小节 | S2（2024 Q4）、S1（2026 Q1）**新增 §2.4.8「TREE@ 算符」**：支持工商树下级名称检索，精确匹配，仅 `AP`/`APTT`/`AP-GROUP`/`AP-GROUPTT` 可用 | S1 §2.4.8、S2、S3 对比 |
| **2** | **新增 §2.4.8「其他规则」独立成节，并新增「符号处理规则」** | 旧版 §2.4 无「其他规则」小节 | S1/S2 **新增 §2.4.9「其他规则」**，其中 `"."`、`"/"`、`"-"`、`"&"`、汉字段的符号处理规则为**新增细化说明**（如 `AP=(amazon.com)` 与 `AP=(amazon com)` 结果不同） | S1 §2.4.9、S2 |
| **3** | **新增检索式长度上限的明确说明** | 旧版未明确 | S1：**长度建议不要超过 2 万字符**；且「不区分大小写和中英文输入法」 | S1 §2.4.9 |
| **4** | **新增「同句/同段算符支持和位置算符嵌套使用」** | S3（2020-12）只列出了同句/同段算符的一系列「不支持」（不支持与位置算符连用、不支持与截词符连用、不支持与 not 连用） | S1/S2 **新增一条正向说明**：「**同句/同段算符支持和位置算符嵌套使用，支持和 not 连用，注意 not 不能作为 (S/P) 的两侧的检索要素中的内容**」 | S1 §2.4.6、S3 §2.4.6 对比 |
| **5** | **新增 `RAD` / `RPD` 两个语义排序字段** | S3（2020-12）超级排序章节**只有 `R`** | S1/S2 **新增 `RAD`（按第一个号码的申请日限定）与 `RPD`（按第一个号码的公开日限定）**，并明确「`R` 的位置只能在检索式的**开头或结尾**，多个技术用 `|` 分隔」 | S1 §2.4.7、S2、S3 对比 |
| **6** | **位置符参数范围的明确化** | 旧版示例存在，但未给出取值范围 | S1/S2 表 2-1 明确「介入字/单词数 **1-99**」；官方前端校验文案进一步给出 **0~99** | S1 §2.4.2、S6 |
| **7** | **范围运算符 `<` `<=` `>` `>=` 及使用限制的完整化** | S3 已有范围运算符的雏形描述 | S1/S2 明确四种运算符、`(a<=x<=b)` 形式，并**新增三条限制**：时间类型需 4/6/8 位且前后统一；数值类型需非负整数；**左右必须使用括号** | S1 §2.4.4、S2 |
| **8** | **高级检索新增「智能检索式」模式** | 旧版无 | 官网更新动态（2025-07-14）：**高级检索新增「智能检索式」模式**，基于检索式构建逻辑结合大模型等 AI 算法，将技术文本到检索式的流程分步自动化 | 官网首页更新动态（同域 `https://www.incopat.com/`） |
| **9** | **语义检索算法升级（语义检索 2.0）** | 旧版无 | 官网首页提供「**查看语义检索算法升级说明**」（`home/yuyisearch`），宣称「更加聚焦于专利的主题意图，更精准的检索体验」 | 官网首页（同域） |
| **10** | **新增图形检索（以图搜发明）** | 旧版无 | 官网更新动态（2025-08-14）：新增图形检索发明专利功能，上传结构图/流程图/原理图/示意图即可匹配相关附图，「无须再依赖复杂的检索式」 | 官网首页更新动态 |
| **11** | **字段规模扩张** | S4（2019-05）：**266 个字段** | S10（旗舰版）：**330 多个字段**；并且旗舰版引入 **DWPI 数据**（DWPI 同族、DWPI 手工代码、DWPI 分类号、DWPI 专利权人代码等一大批新字段） | S4 §2.1.1、S10、S6 字段表 |
| **12** | **新增多类数据源与分类维度** | 旧版分类维度较少 | S1/S2 新增/扩展：**战略新兴产业分类、知识密集型分类、清洁能源产业、清洁生产产业、数字经济核心产业、学科分类（WOS）、国民经济行业分类、CPC、日本 FI/F-term、洛迦诺**等；官方更新动态（2025-11-13）**新增 ANSI / IEC / ISO / CEN 标准数据**（共 7 类标准数据） | S1 §2.3.3、S6 字段表、官网更新动态 |
| **13** | **新增 DWPI 专利权人代码查询工具** | 旧版无 | 官网更新动态（2025-10-30）：旗舰版辅助查询工具新增 DWPI 专利权人代码查询，支持通过**四字代码（如 SONY）**或公司名称快速查找企业 | 官网更新动态 |

### 15.2 **仅存在于当前线上系统**、官方手册 §2.4 未收录的算符/规则

以下条目在 **S1–S5 五份官方培训手册的 §2.4「检索规则」章节中完全未出现**，但在**当前线上系统的官方前端校验资源（S6）中存在**，说明它们是**较新加入线上系统、但纸质/PDF 手册尚未同步收录**的语法：

| # | 算符/规则 | 官方前端文案（原文） | 说明 |
| --- | --- | --- | --- |
| **A** | **频率算符 `(nf)` —— 全新，手册未收录** | `频率算符(nf)，限定关键词在该字段中出现频率≥n`；`1~100 之间`；格式 `（FIELD < NUM）` | 全部 5 份官方手册 §2.4 中**均无「频率算符」小节**。属于线上已有、手册未收录的新算符。且限制极多（不支持与 R/RAD/RPD、同句、同段、位置符、字段、表达式嵌套，且自身不能嵌套） |
| **B** | **可选算符 `OPT` —— 全新，手册未收录** | `可选运算符`；`可选算符只能用于限定在布尔检索后面`；`可选运算符内仅支持 OR 运算`；`仅支持一个可选运算符`；`可选算符不支持和 R 同时存在` | 全部 5 份官方手册中**均无 OPT**。线上系统支持 |
| **C** | **语义算符的三条硬性语法约束 —— 手册未收录** | `语义运算符只能出现在检索式的开头或结尾`；`语义算符的值必须带有括号`；**`语义算符前后只能连接逻辑运算符 AND`** | 手册（S1 §2.4.7）只说「`R` 的位置只能在检索式的开头或者结尾」，**没有**「前后只能连接 AND」「值必须带括号」这两条 |
| **D** | **`(S)`/`(P)` 与 `not` 的互斥校验** | `同句或同段运算符不能与逻辑运算符 not 同时使用` | 与 S1 §2.4.6「同句/同段算符……支持和 not 连用」**表述存在张力**：手册说「支持」，校验文案说「不能与 not 同时使用」。实际以系统校验为准 —— 即 **`not` 不能出现在 `(S)`/`(P)` 两侧的检索要素内部**（手册后半句亦是此意） |
| **E** | **预检索功能的算符黑名单** | `检索式中出现 W/N，(S)，(P)，R，RAD，RPD 时，暂不支持预检索` | 手册未提及 |
| **F** | **检索式长度/复杂度阈值的具体数值** | `您的检索策略有些复杂，请将检索式简化到 5000 字符后分析` | 注意：**检索式输入上限为 2 万字符（手册）**，但**分析功能要求简化到 5000 字符** —— 两个不同阈值 |
| **G** | **关键词长度上限** | `关键词不超过 50 个字符(25 个中文字)` | 手册未提及（针对频率算符语境） |
| **H** | **`#` 检索历史引用语法** | `可引用检索历史编号进行逻辑组配，例如：#1 and TI=computer` | 手册 §2.1.1 只描述 UI 交互，未给出 `#1` 的**文本语法** |

### 15.3 关键**提醒/易错点**（跨版本一致，但极易误解）

1. **`#` 不是注释符，而是检索历史编号引用符**（`#1 and TI=computer`）。这是最常见的误解点。
2. ~~**`(sen)` 不是 incoPat 的算符**~~ —— **已更正（2026-09-22）**：`(sen)` 是 incoPat **旧的同句运算符**，与 `(s)` 等价；官方网页已不再列出，但**数据库仍然支持**（详见 §5.4）。
3. **`!` 不是 incoPat 的通配符** —— 官方只有 `$`、`?`、`*` 三种截词符。
4. **单引号 `'...'` 在 incoPat 中无官方定义**；官方只定义并校验**双引号**。
5. **方括号 `[ ]` 在官方文档中只用于范围检索** `[a to b]`。
6. **截词符仅限于单个英文单词内部和数字中使用**，且不支持与同句/同段算符连用。
7. **同段算符 `(P)` 仅限在中国专利中使用**。
8. **`TREE@` 仅支持 `AP` / `APTT` / `AP-GROUP` / `AP-GROUPTT` 四个字段**，且为**精确匹配**，机构名必须用**双引号**包围。
9. **`R`/`RAD`/`RPD` 与频率算符、`OPT` 均不可同时使用**。
10. **`R` 只能出现在检索式的开头或结尾。**

---

## 16. 未获取到的内容（明确清单）

为遵守「不编造」原则，以下内容**确实未取得**，列出供后续补充：

| # | 未获取到的内容 | 原因 |
| --- | --- | --- |
| 1 | `principal.html`（检索规则）**原文网页** | 公网已下线，返回首页兜底页；存档站点（archive.org 等）在本机网络不可达 |
| 2 | `helpcode.html`（原始字段代码说明）**完整表格（字段代码 + 中文含义 + 检索示例）** | 公网已下线，迁入登录墙后；第三方转载站（patentguru）有反爬拦截 |
| 3 | `helpcodeKin.html`（同族字段代码说明）**完整表格** | 同上 |
| 4 | `formatcode.html`（号码格式说明） | 同上 |
| 5 | `getPdDate...`（数据范围） | 同上 |
| 6 | `journal.html`（更新日志）、`FAQ1.1.html`（常见问题） | 同上 |
| 7 | **表 2-1 / 表 2-2 的原始表格排版**（位置符示例表、范围检索示例表） | 在 PDF 中为**图片**，`pdftotext` 无法提取文字层；本文已按语义还原表 2-1 |
| 8 | **`OPT` 的官方正式定义与检索示例** | 官方手册未收录；仅有系统前端校验文案 |
| 9 | **频率算符 `(nf)` 的官方检索示例** | 官方手册未收录；仅有系统前端校验文案 |
| 10 | **单引号 `'...'` 的语义** | 官方资料中不存在相关说明 |
| 11 | **方括号 `[ ]` 除范围检索外的其他用法** | 官方资料中不存在相关说明 |
| 12 | **注释语法** | 官方资料中不存在（`#` 实为检索历史引用） |
| 13 | ~~**`(sen)` 算符**~~ | ~~官方资料中不存在；非 incoPat 算符~~ → **已更正**：`(sen)` 是旧版同句运算符，与 `(s)` 等价，数据库仍支持（§5.4）；只是已从公开文档中撤下 |
| 14 | **大多数内部字段标识 → 实际检索代码的映射** | 需登录后查「原始字段代码说明」 |

---

## 17. 参考链接

**官方（incoPat / 合享智慧）**

- incoPat 官网：<https://www.incopat.com/>
- 原始字段代码说明（**需登录**）：<https://www.incopat.com/help/sysdoc/helpcode.html>
- 检索规则（**需登录**）：<https://www.incopat.com/help/sysdoc/principal.html>
- 同族字段代码说明（**需登录**）：<https://www.incopat.com/help/sysdoc/helpcodeKin.html>
- 号码格式说明（**需登录**）：<https://www.incopat.com/help/sysdoc/formatcode.html>
- 官方前端 i18n 资源（**公网可取**）：<https://www.incopat.com/resources/js/i18n/search.properties>
- 官方前端 i18n 资源（英文）：<https://www.incopat.com/resources/js/i18n/search_en.properties>
- incoPat 学习中心：<https://learn.incopat.com/#/>
- 合享开放平台：<https://open.incopat.com/>

**官方培训手册 PDF（第三方图书馆托管）**

- incoPat V6.0 使用技巧培训手册，**2026 年 Q1**（东北电力大学图书馆）：<https://lib.neepu.edu.cn/libdownload/incoPatV6.0shouhoupeixunshouce-zhuanyeban.pdf>
- incoPat V6.0 使用技巧培训手册，**2024 年 Q4**（中科院 IAE）：<http://iae.cas.cn/gb2019/xwzx_156509/tzgg_156516/202503/P020250314563279877594.pdf>
- incoPat V6.0 使用技巧培训手册，2020 年 12 月（复旦大学图书馆）：<https://library.fudan.edu.cn/_upload/article/files/cf/82/fcfc67e24105bf7964d71f4b1ce3/b2cce8cb-5e67-4eda-807e-63a52b795f6b.pdf>
- incoPat V6.0 使用手册，2019 年 5 月（中国科学技术大学图书馆）：<https://lib.ustc.edu.cn/wp-content/uploads/2019/07/incoPat-使用手册.pdf>
- incoPat 培训手册（深圳大学图书馆）：<https://www.lib.szu.edu.cn/sites/szulib/files/er/incoPat 培训手册_0.pdf>
- Incopat 使用指引（贵州理工学院图书馆）：<https://www.gzpc.org.cn/f/fileManager/readFile/e68e55d7b0b74c91b3fe11d3532d8a9e>
- incoPat 旗舰版介绍（Clarivate LibGuides）：<https://clarivate.libguides.com/ld.php?content_id=67707292>

**第三方（本次未能取得内容）**

- 顾如专利平台「字段代码说明」：<https://www.patentguru.com/cn/help/code>（反爬拦截，未获取到）
